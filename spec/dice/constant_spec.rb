require 'spec_helper'

RSpec.describe BagOfHolding::Dice::Constant do
  subject { BagOfHolding::Dice::Constant.new value: 5 }

  describe '::new' do
    it 'sets the attributes on the class' do
      const = BagOfHolding::Dice::Constant.new value: 9
      expect(const.value).to eq(9)
    end
  end

  describe '#roll' do
    it 'always rolls to the value' do
      expect(subject.roll).to eq(
        BagOfHolding::Dice::ConstantResult.new value: subject.value
      )
    end
  end

  describe '#==' do
    let(:other) { BagOfHolding::Dice::Constant.new value: 5 }

    it 'returns true when the other constant has a matching value' do
      expect(subject == other).to eq(true)
    end

    it 'returns false when the other constant has a different value' do
      other.value = 9
      expect(subject == other).to eq(false)
    end
  end
end
