require 'exchangerate_host/endpoints/base'
module ExchangerateHost
  module Endpoints
    class Fluctuation < Base
      class << self
        def optional_options
          [:base, :symbols, :places, :amount, :format]
        end

        def required_options
          [:start_date, :end_date]
        end

        def endpoint_path
          'fluctuation'
        end
      end
    end
  end
end
