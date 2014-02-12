module Saxondale
  module ModelMethods

    def expire_etag( type_or_types, opts = {} )
      callbacks = [opts.delete(:when)].flatten.compact
      callbacks << [:after_save, :after_destroy] if callbacks.empty?

      callbacks.each do |callback|
        define_method(callback.to_sym) do
          if self.persisted?
            [type_or_types].flatten.compact.each do |type|
              key = Saxondale::Cache.generate_key(self.class.to_s.classify.tableize, self.id, type.to_s)
              Rails.cache.delete(key)
            end
          end
        end
      end

    end
  end
end