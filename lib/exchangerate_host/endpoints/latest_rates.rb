require 'exchangerate_host/endpoints/base'
module Endpoints
  class LatestRates < Base
    def self.optional_options
      [:base, :symbols, :places, :amount, :format]
    end

    def self.endpoint_path
      'latest'
    end
  end
end
