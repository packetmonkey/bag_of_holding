RSpec.describe BagOfHolding::Dice::MultiplicationOperation do
  let(:left) { BagOfHolding::Dice::Constant.new value: 4 }
  let(:right) { BagOfHolding::Dice::Constant.new value: 2 }

  subject do
    BagOfHolding::Dice::MultiplicationOperation.new left: left,
                                                    right: right
  end

  describe '#value' do
    it 'subtracts the right value from the left' do
      expect(subject.value).to eq(8)
    end
  end

  describe '#operator' do
    it 'returns *' do
      expect(subject.operator).to eq('*')
    end
  end
end
