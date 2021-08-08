require 'exchangerate_host/endpoints/base'
module ExchangerateHost
  module Endpoints
    class TimeSeries < Base
      def self.optional_options
        [:base, :symbols, :places, :amount, :format]
      end

      def self.required_options
        [:start_date, :end_date]
      end

      def self.endpoint_path
        'timeseries'
      end
    end
  end
end