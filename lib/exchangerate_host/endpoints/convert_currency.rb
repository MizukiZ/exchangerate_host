require 'exchangerate_host/endpoints/base'
module ExchangerateHost
  module Endpoints
    class ConvertCurrency < Base
      class << self
        def optional_options
          [:base, :symbols, :places, :amount, :format, :date]
        end

        def required_options
          [:from, :to]
        end

        def endpoint_path
          'convert'
        end
      end
    end
  end
end