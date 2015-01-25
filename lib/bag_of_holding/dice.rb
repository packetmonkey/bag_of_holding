require 'bag_of_holding/dice/constant'
require 'bag_of_holding/dice/constant_result'

require 'bag_of_holding/dice/die'
require 'bag_of_holding/dice/die_validator'
require 'bag_of_holding/dice/die_roller'
require 'bag_of_holding/dice/die_result'

require 'bag_of_holding/dice/operation'
require 'bag_of_holding/dice/operation_result'

require 'bag_of_holding/dice/parser'

require 'bag_of_holding/dice/pool'
require 'bag_of_holding/dice/pool_factory'
require 'bag_of_holding/dice/pool_result'

require 'bag_of_holding/dice/transform'

module BagOfHolding
  # Public: Bag of Holding dice bag. All you need for your myriad of dice
  # rolling needs.
  #
  # Examples
  #
  #   BagOfHolding::Dice.roll '1d20+5'
  #   # => [BagOfHolding::Dice::OperationResult]
  module Dice
    class << self
      def roll(str)
        tree = Parser.new.parse str
        rollables = Transform.new.apply(tree)
        rollables.map(&:roll)
      end
    end
  end
end
