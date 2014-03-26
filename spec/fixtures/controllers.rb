require 'spec_helper'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end


class ImagesController < ApplicationController
  include Saxondale::ControllerMethods
  include Rails.application.routes.url_helpers

  etag :thumbnail

  def thumbnail
    @image = Image.new
    filename = 'hiking.png'
    content = File.read(File.join('spec/fixtures/', filename))

    send_data(content,
      :filename => filename, 
      :disposition => :inline, 
      :type => Rack::Mime.mime_type(File.extname(filename)))
  end

  # def render(*attributes)
  #   puts "REnder: #{attributes}"
  # end

end