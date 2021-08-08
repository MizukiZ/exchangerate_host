RSpec.describe ExchangerateHost::Endpoints::SupportedSymbols do
  describe '.query_options' do
    context 'when invalid option is passed' do
      invalid_option = { base: 'AUD' }
      it 'raises runtime error' do
        expect { ExchangerateHost::Endpoints::SupportedSymbols.query_options(invalid_option) }.to raise_error(RuntimeError, /Invalid options\/values detected/)
      end
    end
  end
end
