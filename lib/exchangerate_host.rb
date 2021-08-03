require 'exchangerate_host/configurations'
require 'exchangerate_host/endpoints/latest_rates'
require 'exchangerate_host/endpoints/supported_symbols'
require 'exchangerate_host/endpoints/convert_currency'
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
      Endpoints::LatestRates.request(options)
    end

    def convert_currency(options = {})
      Endpoints::ConvertCurrency.request(options)
    end

    def supported_symbols(options = {})
      Endpoints::SupportedSymbols.request(options)
    end
  end
end
