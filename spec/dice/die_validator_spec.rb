RSpec.describe BagOfHolding::Dice::DieValidator do
  let(:die) { BagOfHolding::Dice::Die.new sides: 20 }
  subject { BagOfHolding::Dice::DieValidator.new die: die }

  context 'with a reroll higher than explode' do
    before do
      die.explode = 10
      die.reroll = 11
    end

    it 'returns false' do
      expect(subject.valid?).to eq(false)
    end
  end

  context 'with a reroll of 20' do
    before do
      die.reroll = 20
    end

    it 'returns false' do
      expect(subject.valid?).to eq(false)
    end
  end

  context 'with an explode of 1' do
    before do
      die.explode = 1
    end

    it 'returns false' do
      expect(subject.valid?).to eq(false)
    end
  end

  context 'with an explode equal to reroll' do
    before do
      die.explode = 10
      die.reroll  = 10
    end

    it 'returns false' do
      expect(subject.valid?).to eq(false)
    end
  end

  context 'with no sides set' do
    before { die.sides = nil }

    it 'returns false' do
      expect(subject.valid?).to eq(false)
    end
  end
end
