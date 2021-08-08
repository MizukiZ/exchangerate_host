RSpec.describe ExchangerateHost do
  it "has a version number" do
    expect(ExchangerateHost::VERSION).not_to be nil
  end

  describe '.configurations' do
    it 'returns Configurations' do
      expect(ExchangerateHost.configurations).to be_a(ExchangerateHost::Configurations)
    end
  end

  describe '.configure' do
    before(:all) do
      ExchangerateHost.configure do |config|
        config.base = 'USD'
        config.symbols = ['AUD', 'JPY']
        config.amount = 100
      end
    end

    it 'sets configurations' do
      expect(ExchangerateHost.configurations.base).to eq('USD')
      expect(ExchangerateHost.configurations.symbols).to eq(['AUD', 'JPY'])
      expect(ExchangerateHost.configurations.amount).to eq(100)
    end
  end

  describe '.rest_configurations' do
    before(:all) do
      ExchangerateHost.configure do |config|
        config.base = 'USD'
      end
    end

    it 'resets configuration values' do
      ExchangerateHost.reset_configurations
      expect(ExchangerateHost.configurations.base).to be_nil
    end
  end

  describe '.latest_rates' do
    it 'returns rates scoped data' do
      res_body = { 'rates' => { 'data' => 'some data' } }.to_json
      allow(ExchangerateHost::Endpoints::LatestRates).to receive(:request).and_return(res_body)

      expect(ExchangerateHost.latest_rates).to eq({ 'data' => 'some data' })
    end
  end

  describe '.convert_currency' do
    it 'returns result scoped data' do
      res_body = { 'result' => { 'data' => 'some data' } }.to_json
      allow(ExchangerateHost::Endpoints::ConvertCurrency).to receive(:request).and_return(res_body)

      expect(ExchangerateHost.convert_currency).to eq({ 'data' => 'some data' })
    end
  end

  describe '.historical_rates' do
    it 'returns rates scoped data' do
      res_body = { 'rates' => { 'data' => 'some data' } }.to_json
      allow(ExchangerateHost::Endpoints::HistoricalRates).to receive(:request).and_return(res_body)

      expect(ExchangerateHost.historical_rates('2021-01-01')).to eq({ 'data' => 'some data' })
    end
  end

  describe '.latest_rates' do
    it 'returns rates scoped data' do
      res_body = { 'rates' => { 'data' => 'some data' } }.to_json
      allow(ExchangerateHost::Endpoints::LatestRates).to receive(:request).and_return(res_body)

      expect(ExchangerateHost.latest_rates).to eq({ 'data' => 'some data' })
    end
  end

  describe '.time_series' do
    it 'returns rates scoped data' do
      res_body = { 'rates' => { 'data' => 'some data' } }.to_json
      allow(ExchangerateHost::Endpoints::TimeSeries).to receive(:request).and_return(res_body)

      expect(ExchangerateHost.time_series).to eq({ 'data' => 'some data' })
    end
  end

  describe '.fluctuation' do
    it 'returns rates scoped data' do
      res_body = { 'rates' => { 'data' => 'some data' } }.to_json
      allow(ExchangerateHost::Endpoints::Fluctuation).to receive(:request).and_return(res_body)

      expect(ExchangerateHost.fluctuation).to eq({ 'data' => 'some data' })
    end
  end

  describe '.supported_symbols' do
    it 'returns symbols scoped data' do
      res_body = { 'symbols' => { 'rates' => { 'data' => 'some data' } } }.to_json
      allow(ExchangerateHost::Endpoints::SupportedSymbols).to receive(:request).and_return(res_body)

      expect(ExchangerateHost.supported_symbols).to eq({ 'rates' => { 'data' => 'some data' } })
    end
  end
end
