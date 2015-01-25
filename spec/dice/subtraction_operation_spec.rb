RSpec.describe BagOfHolding::Dice::SubtractionOperation do
  let(:left) { BagOfHolding::Dice::Constant.new value: 11 }
  let(:right) { BagOfHolding::Dice::Constant.new value: 7 }

  subject do
    BagOfHolding::Dice::SubtractionOperation.new left: left,
                                                 right: right
  end

  describe '#value' do
    it 'subtracts the right value from the left' do
      expect(subject.value).to eq(4)
    end
  end

  describe '#operator' do
    it 'returns -' do
      expect(subject.operator).to eq('-')
    end
  end
end
