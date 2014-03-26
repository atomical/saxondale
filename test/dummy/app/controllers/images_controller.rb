class ImagesController < ApplicationController
  etag :thumbnail

  def thumbnail
    @image = Image.new
    filename = 'hiking.png'
    content = IO.read(File.join(Rails.root,'app/assets/images/', filename))

    send_data(content,
      :filename => filename, 
      :disposition => :inline, 
      :type => Rack::Mime.mime_type(File.extname(filename)))
  end
end