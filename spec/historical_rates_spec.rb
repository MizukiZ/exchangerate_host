RSpec.describe Endpoints::HistoricalRates do
  describe '#query_options' do

    context 'when invalid option is passed' do
      invalid_option = { from: 'AUD' }
      it 'raises runtime error' do
        expect { Endpoints::HistoricalRates.query_options(invalid_option) }.to raise_error(RuntimeError)
      end
    end
  end
end
