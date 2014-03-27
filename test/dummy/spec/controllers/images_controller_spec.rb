require 'spec_helper'
require 'digest/md5'

describe ImagesController do
  render_views

  describe '#thumbnail' do

    let(:thumbnail){ IO.read(File.join(Rails.root,'app/assets/images/', 'hiking.png')) }
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
        get :thumbnail, :id => 1
        expect(response.headers['ETag']).to eq hash
      end

      it 'does not return image' do
        request.env['If-None-Match'] = hash
        get :thumbnail, :id => 1
        expect(response.body.length).to eq 1
      end

      it 'does not yield to controller' do
        expect_any_instance_of(ImagesController).to_not receive(:send_data)
        Rails.cache.write(Saxondale::Cache.generate_key('images', 1, 'thumbnail'), hash)
        request.env['If-None-Match'] = hash
        get :thumbnail, :id => 1
      end
    end


    context 'uncached' do
      it 'yields to controller without etag in header' do
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