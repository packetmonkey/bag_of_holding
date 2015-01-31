module BagOfHolding
  module Dice
    # Internal: Contains information about the number of dice in a pool, the
    # description of those dice and a label if it has one.
    class Pool
      attr_accessor :count, :die, :label, :high, :drop

      def initialize(count: nil, die: nil, label: nil, high: nil, drop: nil)
        self.count  = count
        self.die    = die
        self.label  = label
        self.high   = high
        self.drop   = drop
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
        @value ||= calculate_value
      end

      def calculate_value
        calculate_high || calculate_drop || calculate_sum
      end

      def calculate_high
        die_values.sort.reverse.slice(0, high).reduce(&:+) if high
      end

      def calculate_drop
        return unless drop

        kept_dice_count = (die_values.length - drop) * -1
        kept_dice = die_values.sort.slice(kept_dice_count, die_values.length)
        kept_dice.reduce(&:+)
      end

      def calculate_sum
        die_values.reduce(&:+)
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
