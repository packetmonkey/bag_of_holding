require 'spec_helper'

RSpec.describe BagOfHolding::Dice::DieRoller do
  let(:die) { BagOfHolding::Dice::Die.new sides: 20, explode: 19, reroll: 2 }
  subject { BagOfHolding::Dice::DieRoller.new die: die }

  # Spec ::build
  describe '::roll' do
    it 'passes the argument to new' do
      klass = BagOfHolding::Dice::DieRoller
      die = double('Die', roll: true)
      expect(klass).to receive(:new).with(die: die).and_return(subject)
      klass.roll die
    end
  end

  describe '#roll' do
    context 'with no options' do
      it 'returns the roll' do
        allow(subject).to receive(:rng).and_return(5)
        expect(subject.roll).to eq(
          BagOfHolding::Dice::DieResult.new rolls: [5],
                                            value: 5,
                                            die: subject
          )
      end
    end

    context 'with rerolling die' do
      it 're-rolls and adds a number larger if we are equal to the reroll' do
        allow(subject).to receive(:rng).and_return(2, 3)
        expect(subject.roll).to eq(
          BagOfHolding::Dice::DieResult.new rolls: [2, 3],
                                            value: 3,
                                            die: subject
        )
      end

      it 're-rolls and adds a number larger if we are less than the reroll' do
        allow(subject).to receive(:rng).and_return(1, 5)
        expect(subject.roll).to eq(
          BagOfHolding::Dice::DieResult.new rolls: [1, 5],
                                            value: 5,
                                            die: subject
        )
      end
    end

    context 'with an exploding die' do
      it 'accumulates and re-rolls if we are equal to the explode number' do
        allow(subject).to receive(:rng).and_return(19, 3)
        expect(subject.roll).to eq(
          BagOfHolding::Dice::DieResult.new rolls: [19, 3],
                                            value: 22,
                                            die: subject
        )
      end

      it 'accumulates and re-rolls if we are greater than the explode number' do
        allow(subject).to receive(:rng).and_return(20, 5)
        expect(subject.roll).to eq(
          BagOfHolding::Dice::DieResult.new rolls: [20, 5],
                                            value: 25,
                                            die: subject
        )
      end

      it 'accumulates and re-rolls if we continue to explode' do
        allow(subject).to receive(:rng).and_return(20, 20, 4)
        expect(subject.roll).to eq(
          BagOfHolding::Dice::DieResult.new rolls: [20, 20, 4],
                                            value: 44,
                                            die: subject
        )
      end
    end
  end
end
