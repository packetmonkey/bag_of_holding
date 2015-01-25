RSpec.describe BagOfHolding::Dice::DieResult do
  let(:die) { BagOfHolding::Dice::Die.new sides: 4 }
  subject do
    BagOfHolding::Dice::DieResult.new rolls: [1, 4],
                                      value: 4,
                                      die: die
  end

  describe '#initialize' do
    it 'sets the rolls and value attributes' do
      result = BagOfHolding::Dice::DieResult.new rolls: [1, 20],
                                                 value: 20,
                                                 die: die

      expect(result.rolls).to eq([1, 20])
      expect(result.value).to eq(20)
      expect(result.die).to eq(die)
    end
  end

  describe '#add_roll' do
    it 'adds the roll to the end of the rolls' do
      subject.add_roll 8
      expect(subject.rolls).to eq([1, 4, 8])
    end
  end

  describe '#rolls' do
    it 'returns the array of roll results' do
      expect(subject.rolls).to eq([1, 4])
    end
  end

  describe '#value' do
    it 'returns the result value' do
      expect(subject.value).to eq(4)
    end
  end

  describe '#==' do
    let(:other) do
      BagOfHolding::Dice::DieResult.new rolls: [1, 4],
                                        value: 4,
                                        die: die
    end

    it 'returns true when passed another result with equal rolls and value' do
      expect(subject == other).to eq(true)
    end

    it 'returns true when passed another result with equal rolls and value' do
      expect(subject == other).to eq(true)
    end

    it 'returns false when the other result has a different value' do
      other.value = 1
      expect(subject == other).to eq(false)
    end

    it 'returns false when the other result has different rolls' do
      other.rolls = [4]
      expect(subject == other).to eq(false)
    end

    it 'returns false when the other result has a different die' do
      other.die = BagOfHolding::Dice::Die.new sides: 8
      expect(subject == other).to eq(false)
    end
  end
end
