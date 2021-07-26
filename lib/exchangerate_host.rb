require "exchangerate_host/version"
require 'httparty'

module ExchangerateHost
  include HTTParty
  base_uri 'https://api.exchangerate.host'

  class << self
    attr_accessor :default_base, :default_symbols, :default_places

    def latest_rates(options)
      p query_options(options)
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

    private

    def query_options(options)
      symbols = options[:symbols] || default_symbols
      {
        base: options[:base] || default_base,
        symbols: to_upcase_csv(symbols),
        places: options[:places] || default_places
      }
    end

    def to_upcase_csv(array)
      return '' unless array

      array.map(&:upcase).join(',')
    end
  end
end
