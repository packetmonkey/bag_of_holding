module BagOfHolding
  module Dice
    # Internal: Contains information about the number of dice in a pool, the
    # description of those dice and a label if it has one.
    class Pool
      attr_accessor :count, :die, :label, :low, :drop, :modifier

      def initialize(count: nil, die: nil, label: nil, low: nil, drop: nil, modifier: nil)
        self.count    = count
        self.die      = die
        self.label    = label
        self.low      = low
        self.drop     = drop
        self.modifier = modifier
      end

      def ==(other)
        begin
          return false unless count == other.count
          return false unless die == other.die
          return false unless label == other.label
          return false unless low == other.low
          return false unless modifier == other.modifier
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
        return modifier.modify die_values if modifier
        calculate_low || calculate_drop || calculate_sum
      end

      def calculate_low
        die_values.sort.slice(0, low).reduce(&:+) if low
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
