require 'exchangerate_host/endpoints/base'
module Endpoints
  class SupportedSymbols < Base
    def self.optional_options
      [:format]
    end

    def self.endpoint_path
      'symbols'
    end

    def self.response_parser(res_body)
      JSON.parse(res_body)
    end
  end
end
