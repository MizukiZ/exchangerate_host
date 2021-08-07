RSpec.describe Endpoints::SupportedSymbols do
  describe '.query_options' do
    context 'when invalid option is passed' do
      invalid_option = { base: 'AUD' }
      it 'raises runtime error' do
        expect { Endpoints::SupportedSymbols.query_options(invalid_option) }.to raise_error(RuntimeError)
      end
    end
  end
end
