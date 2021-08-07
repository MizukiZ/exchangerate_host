require 'httparty'
require 'date'
module Endpoints
  class Base
    include HTTParty
    base_uri 'https://api.exchangerate.host'

    ACCEPTABLE_DATE_FORMAT = /^\d{4}\-(0[1-9]|1[012])\-(0[1-9]|[12][0-9]|3[01])$/.freeze

    VALID_SYMBOLS = [
      :AED, :AFN, :ALL, :AMD, :ANG, :AOA, :ARS, :AUD, :AWG, :AZN, :BAM, :BBD,
      :BDT, :BGN, :BHD, :BIF, :BMD, :BND, :BOB, :BRL, :BSD, :BTC, :BTN, :BWP,
      :BYN, :BZD, :CAD, :CDF, :CHF, :CLF, :CLP, :CNH, :CNY, :COP, :CRC, :CUC,
      :CUP, :CVE, :CZK, :DJF, :DKK, :DOP, :DZD, :EGP, :ERN, :ETB, :EUR, :FJD,
      :FKP, :GBP, :GEL, :GGP, :GHS, :GIP, :GMD, :GNF, :GTQ, :GYD, :HKD, :HNL,
      :HRK, :HTG, :HUF, :IDR, :ILS, :IMP, :INR, :IQD, :IRR, :ISK, :JEP, :JMD,
      :JOD, :JPY, :KES, :KGS, :KHR, :KMF, :KPW, :KRW, :KWD, :KYD, :KZT, :LAK,
      :LBP, :LKR, :LRD, :LSL, :LYD, :MAD, :MDL, :MGA, :MKD, :MMK, :MNT, :MOP,
      :MRO, :MRU, :MUR, :MVR, :MWK, :MXN, :MYR, :MZN, :NAD, :NGN, :NIO, :NOK,
      :NPR, :NZD, :OMR, :PAB, :PEN, :PGK, :PHP, :PKR, :PLN, :PYG, :QAR, :RON,
      :RSD, :RUB, :RWF, :SAR, :SBD, :SCR, :SDG, :SEK, :SGD, :SHP, :SLL, :SOS,
      :SRD, :SSP, :STD, :STN, :SVC, :SYP, :SZL, :THB, :TJS, :TMT, :TND, :TOP,
      :TRY, :TTD, :TWD, :TZS, :UAH, :UGX, :USD, :UYU, :UZS, :VEF, :VES, :VND,
      :VUV, :WST, :XAF, :XAG, :XAU, :XCD, :XDR, :XOF, :XPD, :XPF, :XPT, :YER,
      :ZAR, :ZMW, :ZWL].freeze

    VALID_FORMAT = [:CSV, :TSV, :XML].freeze

    ALL_OPTIONS_WITH_VALIDATE_METHODS = {
      from: { validate_with: VALID_SYMBOLS, action: :subset },
      to: { validate_with: VALID_SYMBOLS, action: :subset },
      date: { validate_with: ACCEPTABLE_DATE_FORMAT, action: :date },
      start_date: { validate_with: ACCEPTABLE_DATE_FORMAT, action: :date },
      end_date: { validate_with: ACCEPTABLE_DATE_FORMAT, action: :date },
      base: { validate_with: VALID_SYMBOLS, action: :subset },
      symbols: { validate_with: VALID_SYMBOLS, action: :subset },
      places: { validate_with: :PositiveInteger, action: :type },
      amount: { validate_with: :Numeric, action: :type },
      format: { validate_with: VALID_FORMAT, action: :subset },
    }

    def self.available_options
      required_options + optional_options
    end

    def self.endpoint_path
      ''
    end

    def self.optional_options
      raise NotImplementedError
    end

    def self.required_options
      []
    end

    def self.request(options)
      raise NotImplementedError
    end

    def self.request(options)
      res = get(
        "/#{endpoint_path}",
        { query: query_options(options) }
      )
      response_parser(res.body)
    end

    def self.response_parser(res_body)
      JSON.parse(res_body)['rates']
    end

    def self.query_options(options)
      validate(options)

      available_options.each_with_object({}) do |valid_option, query_options|
        option_value = options[valid_option] || ExchangerateHost.configurations.public_send(valid_option)

        option_value = to_upcase_csv(option_value) if valid_option == :symbols

        query_options[valid_option] = option_value
      end.compact
    end

    protected
      def self.to_upcase_csv(array)
        return '' unless array

        array.map(&:upcase).join(',')
      end

      def self.validate_with_type(option, validate_with, v)
        if validate_with == :PositiveInteger
          raise "#{option} must be a positive whole number" unless is_positive_integer?(v)
        elsif validate_with == :Numeric
          raise "#{option} must be a number" unless v.is_a?(Numeric)
        end
      end

      def self.is_positive_integer?(v)
        v.is_a?(Integer) && v > 0
      end

      def self.non_subset_values(array, original_array)
        array.map(&:to_sym) - original_array
      end

      def self.validate_subset(array, original_array)
        invalid_values = non_subset_values(array, original_array)
        raise "Invalid input detected: #{invalid_values.join(', ')}" if invalid_values.any?
      end

      def self.validate_date(date)
        raise 'Invalid date format. Please use YYYY-MM-DD' unless date =~ ACCEPTABLE_DATE_FORMAT
        Date.parse(date) # this is only for validation purpose
      end

      def self.validate(options)
        validate_options(options)

        options.each do |option, value|
          validate_option_values(option, value)
        end
      end

      def self.validate_options(options)
        option_keys = options.keys

        validate_required_options(option_keys) if required_options.any?

        return if option_keys.empty?
        validate_subset(option_keys, available_options)
      end

      def self.validate_option_values(option, v)
        validate_with = ALL_OPTIONS_WITH_VALIDATE_METHODS[option][:validate_with]
        validate_action = ALL_OPTIONS_WITH_VALIDATE_METHODS[option][:action]

        if validate_action == :subset
          validate_subset(Array(v).map(&:upcase), validate_with)
        elsif validate_action == :type
          validate_with_type(option, validate_with, v)
        elsif validate_action == :date
          validate_date(v)
        end
      end

      def self.validate_required_options(option_keys)
        missing_required_options = required_options - option_keys
        raise "Missing required options: #{missing_required_options.join(', ')}" if missing_required_options.any?
      end
  end
end
