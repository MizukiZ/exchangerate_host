require 'exchangerate_host/endpoints/base'
module ExchangerateHost
  module Endpoints
    class HistoricalRates < Base
      class << self
        def optional_options
          [:base, :symbols, :places, :amount, :format]
        end

        def required_options
          [:date]
        end

        def endpoint_path
          @query[:date]
        end
      end
    end
  end
end
