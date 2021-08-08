require 'exchangerate_host/endpoints/base'
module ExchangerateHost
  module Endpoints
    class HistoricalRates < Base
      def self.optional_options
        [:base, :symbols, :places, :amount, :format]
      end

      def self.request(date, options)
        validate_date(date)
        get(
          "/#{date}",
          { query: query_options(options) }
        )
        .body
      end
    end
  end
end
