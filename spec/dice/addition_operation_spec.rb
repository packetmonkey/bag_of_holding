RSpec.describe BagOfHolding::Dice::AdditionOperation do
  let(:left) { BagOfHolding::Dice::Constant.new value: 3 }
  let(:right) { BagOfHolding::Dice::Constant.new value: 5 }
  subject { BagOfHolding::Dice::AdditionOperation.new left: left, right: right }

  describe '::operator' do
    it 'returns +' do
      expect(BagOfHolding::Dice::AdditionOperation.operator).to eq('+')
    end
  end

  describe '#value' do
    it 'adds the left and right values' do
      expect(subject.value).to eq(8)
    end
  end

  describe '#operator' do
    it 'returns +' do
      expect(subject.operator).to eq('+')
    end
  end
end
