module ExchangerateHost
  class Configurations
    attr_accessor :base, :symbols, :places, :amount, :format, :from, :to, :date, :start_date, :end_date

    def initialize
      # Default value can be set here.
      # @places = 2
    end

    def to_options_hash
      self.instance_variables.map do |var|
        [var[1..-1].to_sym, self.instance_variable_get(var)]
      end.to_h
    end
  end
end
