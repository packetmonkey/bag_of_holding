module BagOfHolding
  module Dice
    # Contain all the logic around rolling a die given it's options
    class DieRoller
      def self.roll(die)
        new(die: die).roll
      end

      attr_accessor :die, :current_roll

      def initialize(die:)
        self.die = die
      end

      def roll
        loop do
          self.current_roll = rng
          result.add_roll current_roll

          next if reroll?

          result.value += current_roll

          next if explode?

          break
        end

        result
      end

      def result
        @result ||= BagOfHolding::Dice::DieResult.new(
          value: 0, rolls: [], die: self
        )
      end

      def reroll?
        die.reroll && current_roll <= die.reroll
      end

      def explode?
        die.explode && current_roll >= die.explode
      end

      def rng
        1 + rand(die.sides)
      end
    end
  end
end
