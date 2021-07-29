require 'exchangerate_host/query_options'
require 'exchangerate_host/version'
require 'httparty'

module ExchangerateHost
  include HTTParty

  extend QueryOptions

  base_uri 'https://api.exchangerate.host'

  class << self
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
