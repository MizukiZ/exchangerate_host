require 'exchangerate_host/endpoints/base'

module Endpoints
  class HistoricalRates < Base
    def self.optional_options
      [:base, :symbols, :places, :amount, :format]
    end

    def self.request(date, options)
      validate_date(date)
      res = get(
        "/#{date}",
        { query: query_options(options) }
      )
      JSON.parse(res.body)['rates']
    end
  end
end
