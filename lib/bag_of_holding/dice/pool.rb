module BagOfHolding
  module Dice
    # Internal: Contains information about the number of dice in a pool, the
    # description of those dice and a label if it has one.
    class Pool
      attr_accessor :count, :die, :label

      def initialize(count: nil, die: nil, label: nil)
        self.count  = count
        self.die    = die
        self.label  = label
      end

      def ==(other)
        begin
          return false unless count == other.count
          return false unless die == other.die
          return false unless label == other.label
        rescue NoMethodError
          return false
        end

        true
      end

      def roll
        die_results = count.times.map { die.roll }
        value = die_results.map(&:value).reduce(&:+)
        BagOfHolding::Dice::PoolResult.new die_results: die_results,
                                           value: value,
                                           pool: self
      end

      def to_s
        "#{count}#{die}"
      end
    end
  end
end
