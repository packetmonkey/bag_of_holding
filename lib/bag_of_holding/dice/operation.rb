module BagOfHolding
  module Dice
    # Internal: Encapsulates an operation such as adding two dice pools
    class Operation
      attr_accessor :left, :operator, :right

      def initialize(left: nil, operator: nil, right: nil)
        self.left = left
        self.operator = operator
        self.right = right
      end

      def roll
        left_result = left.roll
        right_result = right.roll

        # We currently only support addition
        value = left_result.value + right_result.value

        BagOfHolding::Dice::OperationResult.new left_result: left_result,
                                                right_result: right_result,
                                                operation: self,
                                                value: value
      end

      def ==(other)
        begin
          return false unless left == other.left
          return false unless operator == other.operator
          return false unless right == other.right
        rescue NoMethodError
          return false
        end

        true
      end
    end
  end
end
