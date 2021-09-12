require 'httparty'
require 'date'
require 'exchangerate_host/endpoints/validation'

module ExchangerateHost
  module Endpoints
    class Base
      include HTTParty
      extend Endpoints::Validation

      base_uri 'https://api.exchangerate.host'

      class << self
        def available_options
          required_options + optional_options
        end

        def endpoint_path
          ''
        end

        def optional_options
          raise NotImplementedError
        end

        def required_options
          []
        end

        def request(options)
          @query = query_options(options)
          res = get(
            "/#{endpoint_path}",
            { query: @query }
          )
          .body

          res = JSON.parse(res) unless @query[:format]
          res
        end

        def query_options(options)
          config_options = ExchangerateHost.configurations.to_options_hash.slice(*available_options)
          merged_options = config_options.merge(options)

          validate(merged_options)
          merged_options[:symbols] = to_upcase_csv(merged_options[:symbols]) if merged_options.key?(:symbols)

          merged_options
        end
      end
    end
  end
end
