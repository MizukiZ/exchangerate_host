RSpec.describe ExchangerateHost::Endpoints::TimeSeries do
  describe '.query_options' do

    context 'when invalid option is passed' do
      invalid_option = { start_date: '2020-01-01', end_date: '2020-01-08', from: 'AUD' }
      it 'raises runtime error' do
        expect {  ExchangerateHost::Endpoints::TimeSeries.query_options(invalid_option) }.to raise_error(RuntimeError)
      end
    end

    context 'when required option is missing' do
      missing_option = { start_date: '2020-01-01', from: 'AUD' }
      it 'raises runtime error' do
        expect {  ExchangerateHost::Endpoints::TimeSeries.query_options(missing_option) }.to raise_error(RuntimeError)
      end
    end
  end
end
