RSpec.describe BagOfHolding::Dice::PoolModifiers::Low do
  subject { BagOfHolding::Dice::PoolModifiers::Low.new count: 2 }

  describe '#initialize' do
    it 'sets the count as passed' do
      modifier = BagOfHolding::Dice::PoolModifiers::Low.new count: 99
      expect(modifier.count).to eq(99)
    end
  end

  describe '#count' do
    it 'returns the modifier count' do
      expect(subject.count).to eq(2)
    end
  end

  describe '#count=' do
    it 'sets the modifier count' do
      subject.count = 3
      expect(subject.count).to eq(3)
    end
  end

  describe '#modify' do
    it 'sums the lowest number of rolls determined by the count' do
      result = subject.modify [1, 3, 5]
      expect(result).to eq(4)
    end
  end

  describe '#==' do
    let(:other) { BagOfHolding::Dice::PoolModifiers::Low.new count: 2 }

    it 'returns true when other has the same count' do
      expect(subject == other).to eq(true)
    end

    it 'returns false when other has a different count' do
      other.count = 3
      expect(subject == other).to eq(false)
    end
  end
end
