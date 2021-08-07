require 'exchangerate_host/configurations'
require 'exchangerate_host/endpoints/latest_rates'
require 'exchangerate_host/endpoints/supported_symbols'
require 'exchangerate_host/endpoints/convert_currency'
require 'exchangerate_host/endpoints/historical_rates'
require 'exchangerate_host/endpoints/time_series'
require 'exchangerate_host/endpoints/fluctuation'
require 'exchangerate_host/version'

module ExchangerateHost
  class << self
    attr_accessor :configurations

    def configurations
      @configurations ||= Configurations.new
    end

    def configure
      yield(configurations)
    end

    def reset_configurations
      @configurations = Configurations.new
    end

    def latest_rates(options = {})
      res = Endpoints::LatestRates.request(options)
      response_parser(res, 'rates')
    end

    def convert_currency(options = {})
      res = Endpoints::ConvertCurrency.request(options)
      response_parser(res, 'result')
    end

    def historical_rates(date, options = {})
      res = Endpoints::HistoricalRates.request(date, options)
      response_parser(res, 'rates')
    end

    def time_series(options = {})
      res = Endpoints::TimeSeries.request(options)
      response_parser(res, 'rates')
    end

    def fluctuation(options = {})
      res = Endpoints::Fluctuation.request(options)
      response_parser(res, 'rates')
    end

    def supported_symbols(options = {})
      res = Endpoints::SupportedSymbols.request(options)
      response_parser(res, 'symbols')
    end

    private
      def response_parser(res, scope = nil)
        parsed_data = JSON.parse(res)
        parsed_data[scope] if scope
      end
  end
end
