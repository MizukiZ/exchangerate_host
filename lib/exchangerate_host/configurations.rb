module ExchangerateHost
  class Configurations
    attr_accessor :base, :symbols, :places, :amount, :format, :from, :to, :date, :start_date, :end_date

    def initialize
      @places = 2
    end

    def print
      self.instance_variables.map do |attribute|
        { attribute => self.instance_variable_get(attribute) }
      end
    end
  end
end
