module Saxondale
  module Cache

    def self.generate_key( klass, id, type, opts = {})
      [ 'etag', klass, id, type, opts[:extra]].compact.join(':')
    end
  end
end