RSpec.describe ExchangerateHost do
  it "has a version number" do
    expect(ExchangerateHost::VERSION).not_to be nil
  end

  describe '#configurations' do
    it 'returns Configurations' do
      expect(ExchangerateHost.configurations).to be_a(Configurations)
    end
  end

  describe '#configure' do
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

  describe '#rest_configurations' do
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

end
