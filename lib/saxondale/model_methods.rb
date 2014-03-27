module Saxondale
  module ModelMethods

    def expire_etag( type_or_types, opts = {} )
      callbacks = [opts.delete(:when)].compact
      callbacks << [:after_save, :before_destroy] if callbacks.empty?
      
      clear_cache = Proc.new{ |model|
          if self.persisted?
            [type_or_types].flatten.compact.each do |type|
              key = Saxondale::Cache.generate_key(self.class.to_s.classify.tableize, self.id, type.to_s)
              Rails.cache.delete(key)
            end
          end
        }

      callbacks.flatten.compact.each{|callback| self.send "#{callback}".to_sym, clear_cache }
    end
  end
end