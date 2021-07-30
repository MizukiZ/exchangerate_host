require 'exchangerate_host/endpoints/base'
module Endpoints
  class SupportedSymbols < Base
    def self.valid_options_with_validation_methods
      @valid_options_with_validation_methods ||= { format: { validate_with: VALID_FORMAT, action: :subset } }
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
