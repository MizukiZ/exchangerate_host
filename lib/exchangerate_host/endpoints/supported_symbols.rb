require 'exchangerate_host/endpoints/base'
module Endpoints
  class SupportedSymbols < Base
    def self.optional_options
      [:format]
    end

    def self.request(options)
      res = get(
        '/symbols',
        { query: query_options(options) }
      )
      JSON.parse(res.body)
    end
  end
end
