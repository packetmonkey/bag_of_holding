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

    it 'with a high of 2' do
      modifier = BagOfHolding::Dice::PoolModifiers::High.new count: 2
      pool = subject.build count: nil,
                           die: [{ sides: 20 }, { high: 2 }],
                           label: 'Spec'
      expect(pool).to eq(
        BagOfHolding::Dice::Pool.new(
          count: 1,
          die: BagOfHolding::Dice::Die.new(sides: 20),
          label: 'Spec',
          modifier: modifier
        )
      )
    end

    it 'with a drop of 2' do
      modifier = BagOfHolding::Dice::PoolModifiers::Drop.new count: 2
      pool = subject.build count: 3,
                           die: [{ sides: 20 }, { drop: 2 }],
                           label: 'Spec'
      expect(pool).to eq(
        BagOfHolding::Dice::Pool.new(
          count: 3,
          die: BagOfHolding::Dice::Die.new(sides: 20),
          label: 'Spec',
          modifier: modifier
        )
      )
    end

    it 'with a low of 2' do
      modifier = BagOfHolding::Dice::PoolModifiers::Low.new count: 2
      pool = subject.build count: nil,
                           die: [{ sides: 20 }, { low: 2 }],
                           label: 'Spec'
      expect(pool).to eq(
        BagOfHolding::Dice::Pool.new(
          count: 1,
          die: BagOfHolding::Dice::Die.new(sides: 20),
          label: 'Spec',
          modifier: modifier
        )
      )
    end
  end
end
