RSpec.describe BagOfHolding::Dice::DieFactory do
  subject { BagOfHolding::Dice::DieFactory }

  describe '::build' do
    it 'builds a 20 sided die' do
      die = subject.build raw_die: [{ sides: 20 }]
      expect(die).to eq(
        BagOfHolding::Dice::Die.new(sides: 20)
      )
    end

    it 'defaults explosions to the number of sides' do
      die = subject.build raw_die: [{ sides: 20 }, { explode: nil }]
      expect(die).to eq(
        BagOfHolding::Dice::Die.new(sides: 20, explode: 20)
      )
    end

    it 'sets the explode value' do
      die = subject.build raw_die: [{ sides: 20 }, { explode: 15 }]
      expect(die).to eq(
        BagOfHolding::Dice::Die.new(sides: 20, explode: 15)
      )
    end

    it 'defaults rerolls to 1' do
      die = subject.build raw_die: [{ sides: 20 }, { reroll: nil }]
      expect(die).to eq(
        BagOfHolding::Dice::Die.new(sides: 20, reroll: 1)
      )
    end

    it 'sets the reroll value' do
      die = subject.build raw_die: [{ sides: 20 }, { reroll: 5 }]
      expect(die).to eq(
        BagOfHolding::Dice::Die.new(sides: 20, reroll: 5)
      )
    end
  end
end
