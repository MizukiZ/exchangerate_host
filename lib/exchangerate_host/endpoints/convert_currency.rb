require 'exchangerate_host/endpoints/base'

module Endpoints
  class ConvertCurrency < Base
    def self.optional_options
      [:base, :symbols, :places, :amount, :format, :date]
    end

    def self.required_options
      [:from, :to]
    end

    def self.endpoint_path
      'convert'
    end

    def self.response_parser(res_body)
      JSON.parse(res_body)['result']
    end
  end
end
