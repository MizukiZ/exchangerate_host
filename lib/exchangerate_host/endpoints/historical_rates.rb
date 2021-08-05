require 'exchangerate_host/endpoints/base'

module Endpoints
  class HistoricalRates < Base
    def self.valid_options_with_validation_methods
      @valid_options_with_validation_methods ||= {
        base: { validate_with: VALID_SYMBOLS, action: :subset },
        symbols: { validate_with: VALID_SYMBOLS, action: :subset },
        places: { validate_with: :PositiveInteger, action: :type },
        amount: { validate_with: :Numeric, action: :type },
        format: { validate_with: VALID_FORMAT, action: :subset },
      }
    end

    def self.request(date, options)
      validate_date(date)
      res = get(
        "/#{date}",
        { query: query_options(options) }
      )
      JSON.parse(res.body)['rates']
    end
  end
end
