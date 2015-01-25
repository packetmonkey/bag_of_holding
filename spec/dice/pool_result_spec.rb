RSpec.describe BagOfHolding::Dice::PoolResult do
  let(:die_results) do
    [
      BagOfHolding::Dice::DieResult.new(rolls: [3], value: 3),
      BagOfHolding::Dice::DieResult.new(rolls: [4], value: 4),
      BagOfHolding::Dice::DieResult.new(rolls: [5], value: 5)
    ]
  end

  subject do
    BagOfHolding::Dice::PoolResult.new(
      die_results: die_results,
      value: 12
    )
  end

  describe '#initialize' do
    it 'sets the die_results and value attributes' do
      result = BagOfHolding::Dice::PoolResult.new die_results: die_results,
                                                  value: 12

      expect(result.die_results).to eq(die_results)
      expect(result.value).to eq(12)
    end
  end

  describe '#==' do
    let(:other) do
      BagOfHolding::Dice::PoolResult.new(
        die_results: subject.die_results,
        value: subject.value
      )
    end

    it 'returns true when compared to an identical pool result' do
      expect(subject == other).to eq(true)
    end

    it 'returns false when compared to a pool with a different value' do
      other.value = 42
      expect(subject == other).to eq(false)
    end

    it 'returns false when compared to a pool with different die results' do
      other.die_results = []
      expect(subject == other).to eq(false)
    end
  end

  describe '#to_s' do
    it 'returns the value and the pool string' do
      subject.pool = double(to_s: '2d20')
      expect(subject.to_s).to eq('12 (2d20)')
    end
  end

  describe '#inspect' do
    it 'returns a string with the specific rolls' do
      subject.pool = double(to_s: '2d20')
      expect(subject.inspect).to eq('12 (2d20) [3] [4] [5]')
    end
  end
end
