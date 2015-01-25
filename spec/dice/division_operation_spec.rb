RSpec.describe BagOfHolding::Dice::DivisionOperation do
  let(:left) { BagOfHolding::Dice::Constant.new value: 4 }
  let(:right) { BagOfHolding::Dice::Constant.new value: 2 }

  subject do
    BagOfHolding::Dice::DivisionOperation.new left: left,
                                              right: right
  end

  describe '::operator' do
    it 'returns /' do
      expect(BagOfHolding::Dice::DivisionOperation.operator).to eq('/')
    end
  end

  describe '#value' do
    it 'subtracts the right value from the left' do
      expect(subject.value).to eq(2)
    end

    it 'rounds down any values' do
      BagOfHolding::Dice::Constant.new value: 5
      BagOfHolding::Dice::Constant.new value: 2
      op = BagOfHolding::Dice::DivisionOperation.new left: left,
                                                     right: right
      expect(op.value).to eq(2)
    end
  end

  describe '#operator' do
    it 'returns /' do
      expect(subject.operator).to eq('/')
    end
  end
end
