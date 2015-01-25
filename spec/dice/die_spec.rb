require 'spec_helper'

RSpec.describe BagOfHolding::Dice::Die do
  subject do
    BagOfHolding::Dice::Die.new sides: 20,
                                explode: 19,
                                reroll: 2
  end

  describe '#initialize' do
    it 'sets the attributes on the class' do
      die = BagOfHolding::Dice::Die.new sides: 8, explode: 20, reroll: 1
      expect(die.sides).to eq(8)
      expect(die.explode).to eq(20)
      expect(die.reroll).to eq(1)
      expect(die.errors).to eq({})
    end
  end

  describe '#sides=' do
    it 'sets the number of sides on the die' do
      subject.sides = 100
      expect(subject.sides).to eq(100)
    end
  end

  describe '#sides' do
    it 'returns the number of sides on the die' do
      expect(subject.sides).to eq(20)
    end
  end

  describe '#explode=' do
    it 'sets the number of explode on the die' do
      subject.explode = 15
      expect(subject.explode).to eq(15)
    end
  end

  describe '#explode' do
    it 'returns the number of explode on the die' do
      expect(subject.explode).to eq(19)
    end
  end

  describe '#reroll=' do
    it 'sets the number of reroll on the die' do
      subject.reroll = 2
      expect(subject.reroll).to eq(2)
    end
  end

  describe '#reroll' do
    it 'returns the number of reroll on the die' do
      expect(subject.reroll).to eq(2)
    end
  end

  describe '#errors' do
    it 'returns the errors hash' do
      expect(subject.errors).to eq({})
    end
  end

  describe '#errors=' do
    it 'sets the errors hash' do
      subject.errors = { sides: ['must exist in 3d space'] }
      expect(subject.errors).to match(
        sides: ['must exist in 3d space']
      )
    end
  end

  describe '#==' do
    let(:other) do
      BagOfHolding::Dice::Die.new sides: subject.sides,
                                  explode: subject.explode,
                                  reroll: subject.reroll
    end

    it 'returns true for a die with the same attributes' do
      expect(subject == other).to eq(true)
    end

    it 'returns false for a die with different sides' do
      other.sides = 10_000
      expect(subject == other).to eq(false)
    end

    it 'returns false for a die with different explode' do
      other.explode = 1
      expect(subject == other).to eq(false)
    end

    it 'returns false for a die with different reroll' do
      other.reroll = 4
      expect(subject == other).to eq(false)
    end
  end

  describe '#valid?' do
    it 'returns true with a valid die' do
      expect(subject.valid?).to eq(true)
    end

    context 'with no sides set' do
      before { subject.sides = nil }

      it 'returns false' do
        expect(subject.valid?).to eq(false)
      end

      it 'sets the correct error flag' do
        subject.valid?
        expect(subject.errors[:sides]).to include("can't be blank")
      end
    end

    context 'with an explode equal to reroll' do
      before do
        subject.explode = 10
        subject.reroll  = 10
      end

      it 'returns false' do
        expect(subject.valid?).to eq(false)
      end

      it 'sets an error on explode' do
        subject.valid?
        expect(subject.errors[:explode]).to include(
          'must be higher than reroll'
        )
      end
    end
  end

  context 'with a reroll higher than explode' do
    before do
      subject.explode = 10
      subject.reroll = 11
    end

    it 'returns false' do
      expect(subject.valid?).to eq(false)
    end

    it 'sets an error on explode' do
      subject.valid?
      expect(subject.errors[:reroll]).to include(
        'must be lower than explode'
      )
    end
  end

  describe '#roll' do
    context 'with an invalid die' do
      before { subject.sides = nil }

      it 'raises a StandardError' do
        expect { subject.roll }.to raise_error(StandardError)
      end
    end

    it 'passes itself to DieRoller' do
      result = BagOfHolding::Dice::DieResult.new rolls: [5],
                                                 value: 5,
                                                 die: subject
      allow(BagOfHolding::Dice::DieRoller).to receive(:roll).and_return(result)
      expect(subject.roll).to eq(result)
    end
  end
end
