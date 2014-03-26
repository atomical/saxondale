require 'digest/md5'
require 'saxondale/cache'

module Saxondale
  module ControllerMethods

    def self.included(base)
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)
    end

    module ClassMethods 
      def etag( method_or_methods, opts = {})
        around_filter :etag_remote_asset, only: [method_or_methods].flatten
      end
    end

    module InstanceMethods
      def etag_remote_asset
        hash = Rails.cache.fetch Saxondale::Cache.generate_key(self.controller_name.classify.tableize, params[:id], params[:action])

        if hash && hash == request.headers['If-None-Match']
          render(nothing: true, status: 304) and return
        else
          asset = (yield).try :first
          parent = instance_variable_get("@#{self.controller_name.singularize}")

          if parent && asset && asset.encoding.name.in?(['ASCII-8BIT','UTF-8'])
            hash = Digest::MD5.hexdigest(asset)
            controller_name = parent.class.to_s.classify.tableize
            Rails.cache.write(Saxondale::Cache.generate_key(controller_name, parent.id, params[:action]), hash)
            response.headers['ETag'] = hash
          end
        end
      end
    end
  end
end