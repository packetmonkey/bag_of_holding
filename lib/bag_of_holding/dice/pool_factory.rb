module BagOfHolding
  module Dice
    # Internal: This class takes the parser output describing a dice pool
    # and builds the correct pool object.
    class PoolFactory
      def self.build(count: nil, die:, label: nil)
        new(count: count, die: die, label: label).build
      end

      def initialize(count: nil, die:, label: nil)
        self.raw_count = count
        self.raw_die = die
        self.raw_label = label
      end

      def build
        BagOfHolding::Dice::Pool.new count: pool_count,
                                     die: die,
                                     label: raw_label,
                                     high: high,
                                     drop: drop,
                                     low: low
      end

      private

      attr_accessor :raw_count, :raw_die, :raw_label

      def high
        high_option = raw_die.find { |o| o.keys.first == :high }
        return nil if high_option.nil?

        value = high_option.values.first
        value.nil? ? 1 : value.to_i
      end

      def low
        low_option = raw_die.find { |o| o.keys.first == :low }
        return nil if low_option.nil?

        value = low_option.values.first
        value.nil? ? 1 : value.to_i
      end

      def drop
        drop_option = raw_die.find { |o| o.keys.first == :drop }
        return nil if drop_option.nil?

        value = drop_option.values.first
        value.nil? ? 1 : value.to_i
      end

      def pool_count
        raw_count.nil? ? 1 : raw_count.to_i
      end

      def die
        DieFactory.build raw_die: raw_die
      end
    end
  end
end
