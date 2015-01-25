RSpec.describe BagOfHolding::Dice::Operation do
  let(:left) { BagOfHolding::Dice::Constant.new value: 3 }
  let(:operator) { '+' }
  let(:right) { BagOfHolding::Dice::Constant.new value: 5 }

  subject do
    BagOfHolding::Dice::Operation.new left: left,
                                      operator: operator,
                                      right: right
  end

  describe '#initialize' do
    it 'sets the attributes passed' do
      op = BagOfHolding::Dice::Operation.new left: left,
                                             operator: operator,
                                             right: right
      expect(op.left).to eq(left)
      expect(op.operator).to eq(operator)
      expect(op.right).to eq(right)
    end
  end

  describe '#roll' do
    it 'returns an OperationResult' do
      expect(subject.roll).to eq(
        BagOfHolding::Dice::OperationResult.new(
          left_result: left.roll,
          right_result: right.roll,
          operation: subject,
          value: 8
        )
      )
    end
  end

  describe '#==' do
    let(:other) do
      BagOfHolding::Dice::Operation.new left: left,
                                        operator: operator,
                                        right: right
    end

    it 'returns true when matching attributes' do
      expect(subject == other).to eq(true)
    end

    it 'returns false with a different left' do
      other.left = BagOfHolding::Dice::Constant.new value: 30
      expect(subject == other).to eq(false)
    end

    it 'returns false with a different operator' do
      other.operator = '-'
      expect(subject == other).to eq(false)
    end

    it 'returns false with a different right' do
      other.left = BagOfHolding::Dice::Constant.new value: 40
      expect(subject == other).to eq(false)
    end
  end
end
