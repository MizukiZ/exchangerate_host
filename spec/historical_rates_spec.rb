RSpec.describe ExchangerateHost::Endpoints::HistoricalRates do
  describe '.query_options' do

    context 'when invalid option is passed' do
      invalid_option = { date: '2020-01-01', from: 'AUD' }
      it 'raises runtime error' do
        expect { ExchangerateHost::Endpoints::HistoricalRates.query_options(invalid_option) }.to raise_error(RuntimeError, /Invalid options\/values detected/)
      end
    end
  end
end
