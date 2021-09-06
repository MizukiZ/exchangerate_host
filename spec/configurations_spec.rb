RSpec.describe ExchangerateHost::Configurations do
  describe '#to_options_hash' do
    let!(:configurations) { ExchangerateHost::Configurations.new }
    before do
      configurations.base = 'AUD'
      configurations.format = 'csv'
    end

    it 'prints all instace variables as hash of Array' do
      expect(configurations.to_options_hash).to eq({ base: 'AUD', format: 'csv' })
    end
  end
end
