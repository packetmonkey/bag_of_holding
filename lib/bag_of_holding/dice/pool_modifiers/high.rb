module BagOfHolding
  module Dice
    module PoolModifiers
      # Public: This class provides the implementation of high/keep allowing
      # the user to roll a pool of dice and only keep the highest `count` rolls
      class High
        attr_accessor :count

        def initialize(count:)
          self.count = count
        end

        def modify(values)
          values.sort.reverse.slice(0, count).reduce(&:+)
        end

        def ==(other)
          count == other.count
        end
      end
    end
  end
end
