require 'saxondale/cache'
require 'saxondale/controller_methods'
require 'saxondale/model_methods'
require 'saxondale/engine'

module Saxondale
end



# require 'digest/md5'

# module Avalon
#   module EtagRemoteAsset

#     def self.generate_key( klass, id, type, opts = {})
#       [ klass, id, type, opts[:extra]].compact.join(':')
#     end

#     module ControllerMethods

#       def etag_remote_asset
#         hash = Rails.cache.fetch EtagRemoteAsset.generate_key(self.controller_name.classify.tableize, params[:id], params[:action])

#         if hash && hash == request.headers['If-None-Match']
#           render(nothing: true, status: 304) and return
#         else
#           asset = (yield).try :first
#           parent = instance_variable_get("@#{self.controller_name.singularize}")
#           if parent && asset && asset.encoding.name == 'ASCII-8BIT'
#             hash = Digest::MD5.hexdigest(asset)
#             controller_name = parent.class.to_s.classify.tableize
#             Rails.cache.write(EtagRemoteAsset.generate_key(controller_name, parent.id, params[:action]), hash)
#             response.headers['ETag'] = hash
#           end
#         end
#       end
#     end

#     module ModelMethods

#       def expire_etags( types )
#         if self.persisted?
#           [types].flatten.each do |type|
#             key = EtagRemoteAsset.generate_key(self.class.to_s.classify.tableize, self.id, type.to_s)
#             Rails.cache.delete(key)
#           end
#         end
#         true
#       end
#     end
#   end
# end

  # def thumbnail
  #   @master_file = MasterFile.find(params[:id])
  #   authorize! :read, @master_file.mediaobject
  #   ds = @master_file.datastreams['thumbnail']
  #   send_data ds.content, :filename => "poster-#{@master_file.pid.split(':')[1]}", :disposition => :inline, :type => ds.mimeType
  # end

  # def poster
  #   @master_file = MasterFile.find(params[:id])
  #   authorize! :read, @master_file.mediaobject
  #   ds = @master_file.datastreams['poster']
  #   send_data ds.content, :filename => "poster-#{@master_file.pid.split(':')[1]}", :disposition => :inline, :type => ds.mimeType
  # end
