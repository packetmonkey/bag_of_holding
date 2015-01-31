module BagOfHolding
  module Dice
    # Internal: This class takes the parser output describing a dice pool
    # and builds the correct pool object.
    class ModifierFactory
      MODIFIER_CLASSES = {
        high: BagOfHolding::Dice::PoolModifiers::High,
        low:  BagOfHolding::Dice::PoolModifiers::Low,
        drop: BagOfHolding::Dice::PoolModifiers::Drop
      }

      def self.build(raw_die: raw_die)
        new(raw_die: raw_die).build
      end

      attr_accessor :raw_die

      def initialize(raw_die:)
        self.raw_die = raw_die
      end

      def build
        modifiers.find { |m| m }
      end

      private

      def modifiers
        MODIFIER_CLASSES.keys.map { |name| modifier(name: name) }
      end

      def modifier(name:)
        return nil unless option name: name
        MODIFIER_CLASSES[name].new count: option_value(name: name)
      end

      def option(name:)
        raw_die.find { |o| o.keys.first == name }
      end

      def option_value(name:)
        value = option(name: name).values.first
        value.nil? ? 1 : value.to_i
      end
    end
  end
end
