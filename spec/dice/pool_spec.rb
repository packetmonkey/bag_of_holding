RSpec.describe BagOfHolding::Dice::Pool do
  let(:die) { BagOfHolding::Dice::Die.new sides: 10 }
  subject { BagOfHolding::Dice::Pool.new count: 2, die: die }

  describe '#initialize' do
    it 'sets the attributes on the class' do
      pool = BagOfHolding::Dice::Pool.new(
        count: 2,
        die: BagOfHolding::Dice::Die.new(sides: 10),
        label: 'Specs'
      )

      expect(pool.count).to eq(2)
      expect(pool.die).to eq(BagOfHolding::Dice::Die.new(sides: 10))
      expect(pool.label).to eq('Specs')
    end
  end

  describe '#count=' do
    it 'sets the number of dice in the pool' do
      subject.count = 100
      expect(subject.count).to eq(100)
    end
  end

  describe '#count' do
    it 'returns the number of dice in the pool' do
      expect(subject.count).to eq(2)
    end
  end

  describe '#die=' do
    it 'sets the die the pool is made of' do
      die = BagOfHolding::Dice::Die.new sides: 76
      subject.die = die
      expect(subject.die).to eq(die)
    end
  end

  describe '#die' do
    it 'returns the die the pool is made of' do
      expect(subject.die).to eq(die)
    end
  end

  describe '#==' do
    let(:other) do
      BagOfHolding::Dice::Pool.new count: subject.count,
                                   die: subject.die,
                                   label: subject.label
    end

    it 'returns true for a pool with the same attributes' do
      expect(subject == other).to eq(true)
    end

    it 'returns false for a pool with a different count' do
      other.count = 10_00
      expect(subject == other).to eq(false)
    end

    it 'returns false for a pool with a different die' do
      other.die = BagOfHolding::Dice::Die.new sides: 4
      expect(subject == other).to eq(false)
    end

    it 'returns false for a pool with a different label' do
      other.label = 'Others'
      expect(subject == other).to eq(false)
    end

    it 'returns false for a pool with a different high' do
      subject.high = 1
      other.high = 2
      expect(subject == other).to eq(false)
    end

    it 'returns false for a pool with a different low' do
      subject.low = 1
      other.low = 2
      expect(subject == other).to eq(false)
    end
  end

  describe '#roll' do
    let(:die_results) do
      [
        BagOfHolding::Dice::DieResult.new(rolls: [3], value: 3),
        BagOfHolding::Dice::DieResult.new(rolls: [5], value: 5),
        BagOfHolding::Dice::DieResult.new(rolls: [1], value: 1)
      ]
    end
    subject { BagOfHolding::Dice::Pool.new count: 3, die: die }

    before :each do
      allow(die).to receive(:roll).and_return(*die_results)
    end

    context 'without a high value' do
      it 'sums the rolls of the dice in the pool' do
        expect(subject.roll).to eq(
          BagOfHolding::Dice::PoolResult.new die_results: die_results,
                                             value: 9,
                                             pool: subject
        )
      end
    end

    context 'with a high value of 1' do
      it 'returns the value of the highest die' do
        subject.high = 1
        expect(subject.roll).to eq(
          BagOfHolding::Dice::PoolResult.new die_results: die_results,
                                             value: 5,
                                             pool: subject
        )
      end
    end

    context 'with a high value of 2' do
      it 'returns the value of the highest die' do
        subject.high = 2
        expect(subject.roll).to eq(
          BagOfHolding::Dice::PoolResult.new die_results: die_results,
                                             value: 8,
                                             pool: subject
        )
      end
    end

    context 'with a low value of 1' do
      it 'returns the value of the lowest die' do
        subject.low = 1
        expect(subject.roll).to eq(
          BagOfHolding::Dice::PoolResult.new die_results: die_results,
                                             value: 1,
                                             pool: subject
        )
      end
    end

    context 'with a low value of 2' do
      it 'returns the value of the lowest die' do
        subject.low = 2
        expect(subject.roll).to eq(
          BagOfHolding::Dice::PoolResult.new die_results: die_results,
                                             value: 4,
                                             pool: subject
        )
      end
    end

    context 'with a drop value of 1' do
      it 'returns the value of the highest die' do
        subject.drop = 1
        expect(subject.roll).to eq(
          BagOfHolding::Dice::PoolResult.new die_results: die_results,
                                             value: 8,
                                             pool: subject
        )
      end
    end

    context 'with a drop value of 2' do
      it 'returns the value of the highest die' do
        subject.drop = 2
        expect(subject.roll).to eq(
          BagOfHolding::Dice::PoolResult.new die_results: die_results,
                                             value: 5,
                                             pool: subject
        )
      end
    end
  end

  describe '#to_s' do
    it 'returns the die str' do
      subject.die = double(to_s: 'd172')
      expect(subject.to_s).to eq('2d172')
    end
  end
end
