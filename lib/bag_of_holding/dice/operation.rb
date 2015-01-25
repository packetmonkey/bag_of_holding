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

      private

      def value
        fail NotImplementedError
      end

      def left_result
        @left_result ||= left.roll
      end

      def right_result
        @right_result ||= right.roll
      end
    end
  end
end
