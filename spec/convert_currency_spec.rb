RSpec.describe  ExchangerateHost::Endpoints::ConvertCurrency do
  describe '.query_options' do

    context 'when invalid option is passed' do
      invalid_option = { from: 'AUD', to: 'JPY', start_date: '2021-08-10' }
      it 'raises runtime error' do
        expect {  ExchangerateHost::Endpoints::ConvertCurrency.query_options(invalid_option) }.to raise_error(RuntimeError)
      end
    end

    context 'when required option is missing' do
      missing_option = { from: 'AUD' }
      it 'raises runtime error' do
        expect {  ExchangerateHost::Endpoints::ConvertCurrency.query_options(missing_option) }.to raise_error(RuntimeError)
      end
    end

    context 'when invalid date format is passed' do
      invalid_date_format_option = { from: 'AUD', to: 'JPY', date: '2000/11/22' }
      it 'raises runtime error' do
        expect {  ExchangerateHost::Endpoints::ConvertCurrency.query_options(invalid_date_format_option) }.to raise_error(RuntimeError)
      end
    end

    context 'when invalid date is passed' do
      invalid_date_option = { from: 'AUD', to: 'JPY', date: '2021-06-31' }
      it 'raises date error' do
        expect {  ExchangerateHost::Endpoints::ConvertCurrency.query_options(invalid_date_option) }.to raise_error(Date::Error)
      end
    end
  end
end
