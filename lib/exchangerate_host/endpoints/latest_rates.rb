require 'exchangerate_host/endpoints/base'
module Endpoints
  class LatestRates < Base
    def self.optional_options
      [:base, :symbols, :places, :amount, :format]
    end

    def self.request(options)
      res = get(
        '/latest',
        { query: query_options(options) }
      )
      JSON.parse(res.body)['rates']
    end
  end
end
