require 'spec_helper'
require 'fixtures/models'

describe Image do
  let(:image){ Image.create }

  it 'removes key from cache when saved' do
    key = Saxondale::Cache.generate_key('images', image.id, 'thumbnail')
    Rails.cache.write(key, 1)
    image.save
    expect(Rails.cache.read(key)).to be_nil
  end

  it 'removes key from cache when destroyed' do
    key = Saxondale::Cache.generate_key('images', image.id, 'thumbnail')
    Rails.cache.write(key, 1)
    image.destroy
    expect(Rails.cache.read(key)).to be_nil
  end

end