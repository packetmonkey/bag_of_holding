module BagOfHolding
  module Dice
    # Internal: Stores a constant value with a rollable API so that this
    # object can be called like a pool or operation.
    class Constant
      attr_accessor :value

      def initialize(value:)
        self.value = value
      end

      def roll
        BagOfHolding::Dice::ConstantResult.new value: value
      end

      def ==(other)
        return false unless other.respond_to? :value
        return false unless value == other.value
        true
      end
    end
  end
end
