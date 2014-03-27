Saxondale

ETags for assets that are delivered with Rails controllers

###Install

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
 
 before_save{ expire_etag :thumbnail }
 before_destroy{ expire_etag: thumbnail }
 
```
