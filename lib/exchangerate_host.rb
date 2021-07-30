require 'exchangerate_host/configurations'
require 'exchangerate_host/query_options'
require 'exchangerate_host/version'
require 'httparty'

module ExchangerateHost
  extend QueryOptions
  include HTTParty

  base_uri 'https://api.exchangerate.host'
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
      res = get(
        '/latest',
        { query: query_options(options) }
      )
      JSON.parse(res.body)['rates']
    end

    def currencies
      # return supoprted currency. format [{description: 'Japanese yen', code, 'JPY'}]
      @currencies ||= JSON.parse(get('/symbols').body)['symbols'].values
    end
  end
end
