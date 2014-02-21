Saxondale

###Install

Add to your Gemfile

```ruby
  gem 'saxondale'
```

```ruby
# app/controllers/image_controller.rb
etag :thumbnail

def thumbnail
  @master_file = MasterFile.find(params[:id])
  authorize! :read, @master_file.mediaobject
  ds = @master_file.datastreams['thumbnail']
  send_data ds.content, :filename => "poster-#{@master_file.pid.split(':')[1]}", :disposition => :inline, :type => ds.mimeType
end
```

```ruby
 # app/models/image.rb
 expire_etag :thumbnail  #options:   when: [:after_save, :after_destroy]
```
