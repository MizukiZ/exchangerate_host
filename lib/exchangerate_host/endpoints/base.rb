require 'httparty'
require 'date'
require 'exchangerate_host/endpoints/validation'

module ExchangerateHost
  module Endpoints
    class Base
      include HTTParty
      extend Endpoints::Validation

      base_uri 'https://api.exchangerate.host'

      def self.available_options
        required_options + optional_options
      end

      def self.endpoint_path
        ''
      end

      def self.optional_options
        raise NotImplementedError
      end

      def self.required_options
        []
      end

      def self.request(options)
        get(
          "/#{endpoint_path}",
          { query: query_options(options) }
        )
        .body
      end

      def self.query_options(options)
        config_options = ExchangerateHost.configurations.to_options_hash.slice(*available_options)
        merged_options = config_options.merge(options)

        validate(merged_options)
        merged_options[:symbols] = to_upcase_csv(merged_options[:symbols]) if merged_options.key?(:symbols)

        merged_options
      end
    end
  end
end
