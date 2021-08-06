require 'exchangerate_host/endpoints/base'

module Endpoints
  class ConvertCurrency < Base
    def self.optional_options
      [:base, :symbols, :places, :amount, :format, :date]
    end

    def self.required_options
      [:from, :to]
    end

    def self.request(options)
      res = get(
        '/convert',
        { query: query_options(options) }
      )
      JSON.parse(res.body)['result']
    end
  end
end
