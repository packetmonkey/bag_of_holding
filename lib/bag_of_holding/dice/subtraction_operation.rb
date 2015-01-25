module BagOfHolding
  module Dice
    # Internal: Encapsulates subtracting two expressions
    class SubtractionOperation < Operation
      def value
        left_result.value - right_result.value
      end

      def operator
        '-'
      end
    end
  end
end
