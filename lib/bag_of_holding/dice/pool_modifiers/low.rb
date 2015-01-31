module BagOfHolding
  module Dice
    module PoolModifiers
      # Public: This class provides the implementation of low allowing
      # the user to roll a pool of dice and only keep the lowest `count` rolls
      class Low
        attr_accessor :count

        def initialize(count:)
          self.count = count
        end

        def modify(values)
          values.sort.slice(0, count).reduce(&:+)
        end

        def ==(other)
          count == other.count
        end
      end
    end
  end
end
