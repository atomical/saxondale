require 'spec_helper'

describe ImagesController, type: :controller do
  render_views

  describe '#thumbnail' do
    let(:image) { Image.create }
    let(:thumbnail){ IO.read('spec/fixtures/hiking.png') }
    let(:hash){ Digest::MD5.hexdigest(thumbnail) }

    context 'content' do
      it 'has the image in the body' do
        get :thumbnail, :id => 1
        expect(response.body).to eq thumbnail
      end
    end

    context 'cached' do
      it 'returns correct header' do
        @request['If-None-Match'] = hash
        get :thumbnail, :id => image.id
        expect(response.headers['ETag']).to eq hash
      end

      it 'does not return image when etag matches image hash' do
        Rails.cache.write(Saxondale::Cache.generate_key( Image.to_s.classify.tableize, image.id, 'thumbnail' ), hash)
        request.env['If-None-Match'] = hash
        get :thumbnail, :id => image.id 
        expect(response.body.length).to eq 1
      end

      it 'does not yield to controller' do
        get :thumbnail, :id => 1
        expect_any_instance_of(ImagesController).to_not receive(:send_data)
        request.env['If-None-Match'] = hash
        get :thumbnail, :id => 1
      end
    end


    context 'uncached' do
      it 'yields to controller without etag in header' do
      	allow_any_instance_of(ImagesController).to receive(:render)
        expect_any_instance_of(ImagesController).to receive(:send_data)
        get :thumbnail, :id => 1
      end
  
      it 'looks in the cache for the key' do
        expect(Rails.cache).to receive(:fetch).once
        get :thumbnail, {:id => 1}
        expect(response).to be_ok
      end

    end
  end
end