RSpec.describe Configurations do
  describe '#print' do
    let!(:configurations) { Configurations.new }
    before do
      configurations.base = 'AUD'
      configurations.format = 'csv'
    end

    it 'prints all instace variables as hash of Array' do
      expect(configurations.print).to eq([{ '@places': 2 }, { '@base': 'AUD' }, { '@format': 'csv'} ])
    end
  end
end
