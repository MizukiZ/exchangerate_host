require 'httparty'
require 'date'
require 'exchangerate_host/endpoints/validation'
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
      validate(options)

      available_options.each_with_object({}) do |valid_option, query_options|
        option_value = options[valid_option] || ExchangerateHost.configurations.public_send(valid_option)

        option_value = to_upcase_csv(option_value) if valid_option == :symbols

        query_options[valid_option] = option_value
      end.compact
    end
  end
end
