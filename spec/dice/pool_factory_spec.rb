require 'spec_helper'

RSpec.describe BagOfHolding::Dice::PoolFactory do
  subject { BagOfHolding::Dice::PoolFactory }

  describe '::build' do
    it 'builds a pool simple labeled 20 sided die' do
      pool = subject.build count: 10, die: [{ sides: 20 }], label: 'Spec'
      expect(pool).to eq(
        BagOfHolding::Dice::Pool.new(
          count: 10,
          die: BagOfHolding::Dice::Die.new(sides: 20),
          label: 'Spec'
        )
      )
    end

    it 'defaults a pool count to 1' do
      pool = subject.build count: nil, die: [{ sides: 20 }], label: 'Spec'
      expect(pool).to eq(
        BagOfHolding::Dice::Pool.new(
          count: 1,
          die: BagOfHolding::Dice::Die.new(sides: 20),
          label: 'Spec'
        )
      )
    end

    it 'defaults explosions to the number of sides' do
      pool = subject.build count: nil,
                           die: [{ sides: 20 }, { explode: nil }]
      expect(pool).to eq(
        BagOfHolding::Dice::Pool.new(
          count: 1,
          die: BagOfHolding::Dice::Die.new(sides: 20, explode: 20)
        )
      )
    end

    it 'sets the explode value' do
      pool = subject.build count: nil,
                           die: [{ sides: 20 }, { explode: 15 }]
      expect(pool).to eq(
        BagOfHolding::Dice::Pool.new(
          count: 1,
          die: BagOfHolding::Dice::Die.new(sides: 20, explode: 15)
        )
      )
    end

    it 'defaults rerolls to 1' do
      pool = subject.build count: nil,
                           die: [{ sides: 20 }, { reroll: nil }]
      expect(pool).to eq(
        BagOfHolding::Dice::Pool.new(
          count: 1,
          die: BagOfHolding::Dice::Die.new(sides: 20, reroll: 1)
        )
      )
    end

    it 'sets the reroll value' do
      pool = subject.build count: nil,
                           die: [{ sides: 20 }, { reroll: 5 }]
      expect(pool).to eq(
        BagOfHolding::Dice::Pool.new(
          count: 1,
          die: BagOfHolding::Dice::Die.new(sides: 20, reroll: 5)
        )
      )
    end
  end
end
