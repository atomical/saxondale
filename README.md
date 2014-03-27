Saxondale

ETags for assets that are delivered with Rails controllers

#####Purpose

The assets in FedoraCommons are expensive to load.  This gem uses Rails conventions
to cache and compare the hashes of ETags.

#####Add to your Gemfile


```ruby
  gem 'saxondale'
```

#####Examples

```ruby
# app/controllers/image_controller.rb
etag :thumbnail

def thumbnail
  @image = Image.find(params[:id])
  authorize! :read, @image
  data_stream = @image.datastreams['thumbnail']
  send_data data_stream.content, 
    filename: 'thumbnail', 
    disposition: :inline, 
    type: ds.mimeType)
end
```


```ruby
 # app/models/image.rb
  expire_etag :thumbnail
 
```
