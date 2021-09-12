require 'exchangerate_host/endpoints/base'
module ExchangerateHost
  module Endpoints
    class HistoricalRates < Base
      class << self
        def optional_options
          [:base, :symbols, :places, :amount, :format]
        end

        def request(date, options)
          validate_date(date)
          query = query_options(options)

          res = get(
            "/#{date}",
            { query: query }
          )
          .body

          res = JSON.parse(res) unless query[:format]
          res
        end
      end
    end
  end
end
