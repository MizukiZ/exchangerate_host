require 'exchangerate_host/endpoints/base'

module Endpoints
  class ConvertCurrency < Base
    def self.valid_options_with_validation_methods
      @valid_options_with_validation_methods ||= {
        from: { validate_with: VALID_SYMBOLS, action: :subset, required: true },
        to: { validate_with: VALID_SYMBOLS, action: :subset, required: true },
        base: { validate_with: VALID_SYMBOLS, action: :subset },
        symbols: { validate_with: VALID_SYMBOLS, action: :subset },
        places: { validate_with: :PositiveInteger, action: :type },
        amount: { validate_with: :Numeric, action: :type },
        format: { validate_with: VALID_FORMAT, action: :subset },
        date: { validate_with: ACCEPTABLE_DATE_FORMAT, action: :date },
      }
    end

    def self.request(options)
      res = get(
        '/convert',
        { query: query_options(options) }
      )
      JSON.parse(res.body)['result']
    end
  end
end
