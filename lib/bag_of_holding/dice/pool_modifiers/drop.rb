module BagOfHolding
  module Dice
    module PoolModifiers
      # Public: This class provides the implementation of low allowing
      # the user to roll a pool of dice and removing the lowest `count` rolls
      class Drop
        attr_accessor :count

        def initialize(count:)
          self.count = count
        end

        def modify(values)
          kept_dice_count = (values.length - count) * -1
          kept_dice = values.sort.slice(kept_dice_count, values.length)
          kept_dice.reduce(&:+)
        end

        def ==(other)
          count == other.count
        end
      end
    end
  end
end
