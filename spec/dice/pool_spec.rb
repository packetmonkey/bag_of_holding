RSpec.describe BagOfHolding::Dice::Pool do
  let(:die) { BagOfHolding::Dice::Die.new sides: 10 }
  subject { BagOfHolding::Dice::Pool.new count: 2, die: die }

  describe '#initialize' do
    it 'sets the attributes on the class' do
      modifier = double('modifer', modify: 1369)
      pool = BagOfHolding::Dice::Pool.new(
        count: 2,
        die: BagOfHolding::Dice::Die.new(sides: 10),
        label: 'Specs',
        modifier: modifier
      )

      expect(pool.count).to eq(2)
      expect(pool.die).to eq(BagOfHolding::Dice::Die.new(sides: 10))
      expect(pool.label).to eq('Specs')
      expect(pool.modifier).to eq(modifier)
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

    it 'returns false for a pool with a different modifier' do
      subject.modifier = double('mod1')
      other.modifier   = double('mod2')
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

    context 'with a modifier' do
      let(:modifier) { double 'modifier' }

      it 'uses the modifier value as a result' do
        allow(modifier).to receive(:modify).with([3, 5, 1]).and_return(13_579)
        subject.modifier = modifier
        expect(subject.roll).to eq(
          BagOfHolding::Dice::PoolResult.new die_results: die_results,
                                             value: 13_579,
                                             pool: subject
        )
      end
    end
  end

  describe '#to_s' do
    it 'returns the die str' do
      subject.label = 'Attack'
      subject.die = double(to_s: 'd172')
      expect(subject.to_s).to eq('Attack 2d172')
    end
  end
end
