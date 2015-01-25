RSpec.describe BagOfHolding::Dice::Transform do
  subject       { BagOfHolding::Dice::Transform.new }
  let(:parser)  { BagOfHolding::Dice::Parser.new    }

  describe '#apply' do
    it 'transforms 5' do
      tree = parser.parse '5'
      expect(subject.apply(tree)).to match([
        BagOfHolding::Dice::Constant.new(value: 5)
      ])
    end

    it 'transforms 1d20' do
      tree = parser.parse '1d20'
      expect(subject.apply(tree)).to match([
        BagOfHolding::Dice::Pool.new(
          count: 1,
          die: BagOfHolding::Dice::Die.new(sides: 20)
        )
      ])
    end

    it 'transforms 1d20,1d8' do
      tree = parser.parse '1d20,1d8'
      expect(subject.apply(tree)).to match([
        BagOfHolding::Dice::Pool.new(
          count: 1,
          die: BagOfHolding::Dice::Die.new(sides: 20)
        ),
        BagOfHolding::Dice::Pool.new(
          count: 1,
          die: BagOfHolding::Dice::Die.new(sides: 8)
        )
      ])
    end

    it 'transforms d20' do
      tree = parser.parse 'd20'
      expect(subject.apply(tree)).to match([
        BagOfHolding::Dice::Pool.new(
          count: 1,
          die: BagOfHolding::Dice::Die.new(sides: 20)
        )
      ])
    end

    it 'transforms 3d8 (Attack)' do
      tree = parser.parse '3d8 (Attack)'
      expect(subject.apply(tree)).to match([
        BagOfHolding::Dice::Pool.new(
          count: 3,
          label: 'Attack',
          die: BagOfHolding::Dice::Die.new(sides: 8)
        )
      ])
    end

    it 'transforms 1d20r' do
      tree = parser.parse '1d20r'
      expect(subject.apply(tree)).to match([
        BagOfHolding::Dice::Pool.new(
          count: 1,
          die: BagOfHolding::Dice::Die.new(sides: 20, reroll: 1)
        )
      ])
    end

    it 'transforms 5+6' do
      tree = parser.parse '5+6'
      expect(subject.apply(tree)).to match([
        BagOfHolding::Dice::AdditionOperation.new(
          left: BagOfHolding::Dice::Constant.new(value: 5),
          operator: '+',
          right: BagOfHolding::Dice::Constant.new(value: 6)
        )
      ])
    end

    it 'transforms 8, 9' do
      tree = parser.parse '8, 9'
      expect(subject.apply(tree)).to match([
        BagOfHolding::Dice::Constant.new(value: 8),
        BagOfHolding::Dice::Constant.new(value: 9)
      ])
    end

    it 'transforms 1 + 2, 3' do
      tree = parser.parse '1 + 2, 3'
      expect(subject.apply(tree)).to match([
        BagOfHolding::Dice::AdditionOperation.new(
          left: BagOfHolding::Dice::Constant.new(value: 1),
          operator: '+',
          right: BagOfHolding::Dice::Constant.new(value: 2)
        ),
        BagOfHolding::Dice::Constant.new(value: 3)
      ])
    end

    it 'transforms 1d20r (Defense)' do
      tree = parser.parse '1d20r (Defense)'
      expect(subject.apply(tree)).to match([
        BagOfHolding::Dice::Pool.new(
          count: 1,
          die: BagOfHolding::Dice::Die.new(sides: 20, reroll: 1),
          label: 'Defense'
        )
      ])
    end

    it 'transforms 1d20r2' do
      tree = parser.parse '1d20r2'
      expect(subject.apply(tree)).to match([
        BagOfHolding::Dice::Pool.new(
          count: 1,
          die: BagOfHolding::Dice::Die.new(sides: 20, reroll: 2)
        )
      ])
    end

    it 'transforms 1d20e' do
      tree = parser.parse '1d20e'
      expect(subject.apply(tree)).to match([
        BagOfHolding::Dice::Pool.new(
          count: 1,
          die: BagOfHolding::Dice::Die.new(sides: 20, explode: 20)
        )
      ])
    end

    it 'transforms 1d20e18' do
      tree = parser.parse '1d20e18'
      expect(subject.apply(tree)).to match([
        BagOfHolding::Dice::Pool.new(
          count: 1,
          die: BagOfHolding::Dice::Die.new(sides: 20, explode: 18)
        )
      ])
    end

    it 'transforms 1d20e18r2' do
      tree = parser.parse '1d20e18r2'
      expect(subject.apply(tree)).to match([
        BagOfHolding::Dice::Pool.new(
          count: 1,
          die: BagOfHolding::Dice::Die.new(sides: 20, explode: 18, reroll: 2)
        )
      ])
    end

    it 'transforms 1d20r2e18' do
      tree = parser.parse '1d20r2e18'
      expect(subject.apply(tree)).to match([
        BagOfHolding::Dice::Pool.new(
          count: 1,
          die: BagOfHolding::Dice::Die.new(sides: 20, explode: 18, reroll: 2)
        )
      ])
    end

    it 'transforms 1d20 + 5' do
      tree = parser.parse '1d20 + 5'
      expect(subject.apply(tree)).to match([
        BagOfHolding::Dice::AdditionOperation.new(
          left: BagOfHolding::Dice::Pool.new(
            count: 1,
            die: BagOfHolding::Dice::Die.new(sides: 20)
          ),
          operator: '+',
          right: BagOfHolding::Dice::Constant.new(value: 5)
        )
      ])
    end

    it 'transforms 2d6r+ 1d4 + 2+1d8' do
      tree = parser.parse '2d6r+ 1d4 + 2+1d8'
      expect(subject.apply(tree)).to match([
        BagOfHolding::Dice::AdditionOperation.new(
          left: BagOfHolding::Dice::Pool.new(
            count: 2,
            die: BagOfHolding::Dice::Die.new(sides: 6, reroll: 1)
          ),
          operator: '+',
          right: BagOfHolding::Dice::AdditionOperation.new(
            left: BagOfHolding::Dice::Pool.new(
              count: 1,
              die: BagOfHolding::Dice::Die.new(sides: 4)
            ),
            operator: '+',
            right: BagOfHolding::Dice::AdditionOperation.new(
              left: BagOfHolding::Dice::Constant.new(value: 2),
              operator: '+',
              right: BagOfHolding::Dice::Pool.new(
                count: 1,
                die: BagOfHolding::Dice::Die.new(sides: 8)
              )
            )
          )
        )
      ])
    end
  end
end
