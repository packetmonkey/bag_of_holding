module BagOfHolding
  module Dice
    # Internal: Wraps the logic that determines if a die can be rolled
    # successfully
    class DieValidator
      def self.valid?(die)
        new(die: die).valid?
      end

      attr_accessor :die

      def initialize(die:)
        self.die = die
      end

      def valid?
        return false unless die.sides
        return false if die.reroll && die.explode && die.reroll >= die.explode
        true
      end
    end
  end
end
