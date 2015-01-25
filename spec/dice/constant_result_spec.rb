require 'spec_helper'

RSpec.describe BagOfHolding::Dice::ConstantResult do
  subject { BagOfHolding::Dice::ConstantResult.new value: 5 }

  describe '::new' do
    it 'sets the attributes on the class' do
      const = BagOfHolding::Dice::ConstantResult.new value: 9
      expect(const.value).to eq(9)
    end
  end

  describe '#value' do
    it 'returns the value' do
      expect(subject.value).to eq(5)
    end
  end

  describe '#value=' do
    it 'sets the value' do
      subject.value = 7
      expect(subject.value).to eq(7)
    end
  end

  describe '#to_s' do
    it 'returns the value as a string' do
      expect(subject.to_s).to eq('5')
    end
  end

  describe '#inspect' do
    it 'returns the value as a string' do
      expect(subject.inspect).to eq('5')
    end
  end

  describe '#==' do
    let(:other) { BagOfHolding::Dice::ConstantResult.new value: 5 }

    it 'returns true when the other constant has a matching value' do
      expect(subject == other).to eq(true)
    end

    it 'returns false when the other constant has a different value' do
      other.value = 99
      expect(subject == other).to eq(false)
    end
  end
end
