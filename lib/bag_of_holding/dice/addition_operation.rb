module BagOfHolding
  module Dice
    # Internal: Encapsulates an operation such as adding two dice pools
    class AdditionOperation < Operation
      def value
        left_result.value + right_result.value
      end

      def operator
        '+'
      end
    end
  end
end
