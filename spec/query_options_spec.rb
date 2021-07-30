RSpec.describe QueryOptions do
  describe '#query_options' do
    before(:all) do
      ExchangerateHost.reset_configurations
      ExchangerateHost.configure do |config|
        config.base = 'JPY'
        config.symbols = ['AUD', 'USD']
      end
    end

    it 'returns default values for not given options' do
      expect(ExchangerateHost.query_options({})).to eq({ base: 'JPY', symbols: 'AUD,USD', places: 2 })
    end

    it 'overwrites default options with given options' do
      options = { base: 'AUD', places: 4 }
      expect(ExchangerateHost.query_options(options)).to eq({ base: 'AUD', symbols: 'AUD,USD', places: 4 })
    end

    it 'accepts non case-sensitive values' do
      non_case_sensitive_values = { base: 'JpY', symbols: ['Awg', 'usD'] }
      expect(ExchangerateHost.query_options(non_case_sensitive_values)).to eq({ base: 'JpY', symbols: 'AWG,USD', places: 2 })
    end

    context 'when invalid option is passed' do
      invalid_option = { esab: 'AUD' }
      it 'raises runtime error' do
        expect { ExchangerateHost.query_options(invalid_option) }.to raise_error(RuntimeError)
      end
    end

    context 'when invalid base option value is passed' do
      invalid_base_value = { base: 'DUA' }
      it 'raises runtime error' do
        expect { ExchangerateHost.query_options(invalid_base_value) }.to raise_error(RuntimeError)
      end
    end

    context 'when invalid symbols option value is passed' do
      invalid_symbols_value = { symbols: 'DUA,JPY' }
      it 'raises runtime error' do
        expect { ExchangerateHost.query_options(invalid_symbols_value) }.to raise_error(RuntimeError)
      end
    end

    context 'when invalid places option value is passed' do
      invalid_places_value = { places: 'abc' }
      it 'raises runtime error' do
        expect { ExchangerateHost.query_options(invalid_places_value) }.to raise_error(RuntimeError)
      end
    end

    context 'when invalid format option value is passed' do
      invalid_format_value = { format: 'abc' }
      it 'raises runtime error' do
        expect { ExchangerateHost.query_options(invalid_format_value) }.to raise_error(RuntimeError)
      end
    end

    context 'when invalid amount option value is passed' do
      invalid_amount_value = { amount: 'abc' }
      it 'raises runtime error' do
        expect { ExchangerateHost.query_options(invalid_amount_value) }.to raise_error(RuntimeError)
      end
    end
  end
end
