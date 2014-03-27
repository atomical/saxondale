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
        hash = Rails.cache.fetch(etag_remote_asset_key)

        if hash && hash == request.headers['If-None-Match']
          render(nothing: true, status: 304) and return
        else
          asset       = (yield).try :first

          if asset && asset.encoding.name.in?(['ASCII-8BIT','UTF-8'])
            hash = Digest::MD5.hexdigest(asset)
            Rails.cache.write(etag_remote_asset_key, hash)
            response.headers['ETag'] = hash
          end
        end
      end

      def etag_remote_asset_key
        Saxondale::Cache.generate_key(self.controller_name.classify.tableize, params[:id], params[:action])
      end
    end
  end
end