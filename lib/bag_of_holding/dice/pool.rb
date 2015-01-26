module BagOfHolding
  module Dice
    # Internal: Contains information about the number of dice in a pool, the
    # description of those dice and a label if it has one.
    class Pool
      attr_accessor :count, :die, :label, :keep

      def initialize(count: nil, die: nil, label: nil, keep: nil)
        self.count  = count
        self.die    = die
        self.label  = label
        self.keep   = keep
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
        BagOfHolding::Dice::PoolResult.new die_results: die_results,
                                           value: value,
                                           pool: self
      end

      def to_s
        "#{count}#{die}"
      end

      private

      def value
        if keep.nil?
          @value = die_values.reduce(&:+)
        else
          @value = die_values.sort.reverse.slice(0, keep).reduce(&:+)
        end

        @value
      end

      def die_values
        @die_values ||= die_results.map(&:value)
      end

      def die_results
        @die_results ||= count.times.map { die.roll }
      end
    end
  end
end
