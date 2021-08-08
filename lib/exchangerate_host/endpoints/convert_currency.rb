require 'exchangerate_host/endpoints/base'
module ExchangerateHost
  module Endpoints
    class ConvertCurrency < Base
      def self.optional_options
        [:base, :symbols, :places, :amount, :format, :date]
      end

      def self.required_options
        [:from, :to]
      end

      def self.endpoint_path
        'convert'
      end
    end
  end
end