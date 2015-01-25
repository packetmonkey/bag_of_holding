module BagOfHolding
  module Dice
    # Internal: Present the 'result' of a constant with a result API so it
    # can be used interchangeably with an OperationResult or a PoolResult
    class ConstantResult
      attr_accessor :value

      def initialize(value: nil)
        self.value = value
      end

      def to_s
        value.to_s
      end

      def inspect
        value.to_s
      end

      def ==(other)
        return false unless other.respond_to? :value
        return false unless value == other.value
        true
      end
    end
  end
end
