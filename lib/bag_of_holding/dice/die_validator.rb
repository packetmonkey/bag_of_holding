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
        sides?                &&
          reroll_explode_gap? &&
          minimum_explode?    &&
          maximum_reroll?     || false
      end

      private

      def sides?
        return true if die.sides
      end

      def reroll_explode_gap?
        return true   if die.reroll.nil?
        return true   if die.explode.nil?
        return false  if die.reroll >= die.explode
        true
      end

      def minimum_explode?
        return true if die.explode.nil?
        return false if die.explode < 2
        true
      end

      def maximum_reroll?
        return true if die.reroll.nil?
        return false if die.reroll >= die.sides
        true
      end
    end
  end
end
