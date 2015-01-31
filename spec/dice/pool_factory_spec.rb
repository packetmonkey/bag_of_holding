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
  end

  describe '#build' do
    it 'calls DieFactory to create the die' do
      die = double('BagOfHolding::Dice::Die')
      allow(BagOfHolding::Dice::DieFactory).to(
        receive(:build).with(raw_die: [{ sides: 20 }]).and_return(die)
      )

      pool = subject.build count: nil, die: [{ sides: 20 }], label: 'Spec'
      expect(pool.die).to eq(die)
    end

    it 'calls ModifierFactory to create the modifier' do
      modifier = double('PoolModifier')
      allow(BagOfHolding::Dice::ModifierFactory).to(
        receive(:build).with(raw_die: [{ sides: 20 }, { drop: 2 }])
                       .and_return(modifier)
      )

      pool = subject.build count: nil,
                           die: [{ sides: 20 }, { drop: 2 }],
                           label: 'Spec'
      expect(pool.modifier).to eq(modifier)
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
  end
end
