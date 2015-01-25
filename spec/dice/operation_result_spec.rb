RSpec.describe BagOfHolding::Dice::OperationResult do
  let(:left) { BagOfHolding::Dice::Constant.new value: 3 }
  let(:right) { BagOfHolding::Dice::Constant.new value: 5 }

  let(:operation) do
    BagOfHolding::Dice::AdditionOperation.new left: left,
                                              right: right
  end

  subject do
    BagOfHolding::Dice::OperationResult.new left_result: left.roll,
                                            operation: operation,
                                            right_result: right.roll,
                                            value: 8
  end

  describe '#initialize' do
    it 'assigns the attributes that are passed' do
      result = BagOfHolding::Dice::OperationResult.new left_result: left.roll,
                                                       operation: operation,
                                                       right_result: right.roll,
                                                       value: 8
      expect(result.left_result).to eq(left.roll)
      expect(result.operation).to eq(operation)
      expect(result.right_result).to eq(right.roll)
      expect(result.value).to eq(8)
    end
  end

  describe '#to_s' do
    it 'returns a string with the left result, operator and right result' do
      expect(subject.to_s).to eq('3 + 5')
    end
  end

  describe '#inspect' do
    it 'returns the inspected left and right results and operator' do
      expect(subject.to_s).to eq('3 + 5')
    end
  end

  describe '#==' do
    let(:other) do
      BagOfHolding::Dice::OperationResult.new left_result: left.roll,
                                              operation: operation,
                                              right_result: right.roll,
                                              value: 8
    end

    it 'returns true when other has matching attributes' do
      expect(subject == other).to eq(true)
    end

    it 'returns false with a different left_result' do
      other.left_result = right.roll
      expect(subject == other).to eq(false)
    end

    it 'returns false with a different right_result' do
      other.right_result = left.roll
      expect(subject == other).to eq(false)
    end
  end
end
