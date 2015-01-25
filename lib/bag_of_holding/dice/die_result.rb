module BagOfHolding
  module Dice
    # Internal: Encapsulate the value of a die roll along with the rolls that
    # where performed to achieve that value.
    class DieResult
      attr_accessor :rolls, :value, :die

      def initialize(rolls: nil, value: nil, die: nil)
        self.rolls = rolls || []
        self.value = value
        self.die = die
      end

      def ==(other)
        return false if value != other.value
        return false if rolls != other.rolls
        return false if die != other.die
        true
      end

      def add_roll(roll)
        rolls.push roll
      end
    end
  end
end
