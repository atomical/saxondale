require 'active_model'
require 'active_record'
require 'saxondale/model_methods'

class Image < ActiveRecord::Base
  extend Saxondale::ModelMethods
  
  expire_etag :thumbnail

end

