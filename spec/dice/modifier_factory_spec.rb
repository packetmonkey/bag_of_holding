RSpec.describe BagOfHolding::Dice::ModifierFactory do
  subject { BagOfHolding::Dice::ModifierFactory }

  describe '::build' do
    it 'builds a 20 sided die' do
      modifier = subject.build raw_die: [{ drop: 2 }]

      expect(modifier).to eq(
        BagOfHolding::Dice::PoolModifiers::Drop.new(count: 2)
      )
    end
  end

  describe '#initialize' do
    it 'sets the raw_die' do
      factory = subject.new raw_die: [{ drop: 2 }]
      expect(factory.raw_die).to eq([{ drop: 2 }])
    end
  end

  describe '#build' do
    subject { BagOfHolding::Dice::ModifierFactory.new raw_die: nil }

    it 'returns a High modifier' do
      subject.raw_die = [{ high: 2 }]
      expect(subject.build).to eq(
        BagOfHolding::Dice::PoolModifiers::High.new count: 2
      )
    end

    it 'returns a Drop modifier' do
      subject.raw_die = [{ drop: 2 }]
      expect(subject.build).to eq(
        BagOfHolding::Dice::PoolModifiers::Drop.new count: 2
      )
    end

    it 'returns a Low modifier' do
      subject.raw_die = [{ low: 2 }]
      expect(subject.build).to eq(
        BagOfHolding::Dice::PoolModifiers::Low.new count: 2
      )
    end
  end
end
