require 'exchangerate_host/endpoints/base'
module ExchangerateHost
  module Endpoints
    class LatestRates < Base
      class << self
        def optional_options
          [:base, :symbols, :places, :amount, :format]
        end

        def endpoint_path
          'latest'
        end
      end
    end
  end
end
