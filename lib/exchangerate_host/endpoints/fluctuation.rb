require 'exchangerate_host/endpoints/base'

module Endpoints
  class Fluctuation < Base
    def self.optional_options
      [:base, :symbols, :places, :amount, :format]
    end

    def self.required_options
      [:start_date, :end_date]
    end

    def self.request(options)
      res = get(
        '/fluctuation',
        { query: query_options(options) }
      )
      JSON.parse(res.body)['rates']
    end
  end
end
