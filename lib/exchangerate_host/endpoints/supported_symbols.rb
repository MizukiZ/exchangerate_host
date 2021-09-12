require 'exchangerate_host/endpoints/base'
module ExchangerateHost
  module Endpoints
    class SupportedSymbols < Base
      class << self
        def optional_options
          [:format]
        end

        def endpoint_path
          'symbols'
        end
      end
    end
  end
end
