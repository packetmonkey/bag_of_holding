module BagOfHolding
  module Dice
    # Internal: Represent the results of an operation such as adding two
    # dice pools.
    class OperationResult
      attr_accessor :left_result, :right_result, :operation, :value

      def initialize(left_result: nil, right_result: nil,
                     operation: nil, value: nil)
        self.left_result = left_result
        self.right_result = right_result
        self.operation = operation
        self.value = value
      end

      def to_s
        "#{left_result} #{operation.operator} #{right_result}"
      end

      def inspect
        "#{left_result.inspect} #{operation.operator} #{right_result.inspect}"
      end

      def ==(other)
        begin
          return false unless left_result == other.left_result
          return false unless right_result == other.right_result
          return false unless operation == other.operation
          return false unless value == other.value
        rescue NoMethodError
          return false
        end

        true
      end
    end
  end
end
