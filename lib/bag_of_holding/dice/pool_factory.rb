module BagOfHolding
  module Dice
    # Internal: This class takes the parser output describing a dice pool
    # and builds the correct pool object.
    class PoolFactory
      def self.build(count: nil, die:, label: nil)
        new(count: count, die: die, label: label).build
      end

      DIE_OPTIONS = [:sides, :reroll, :explode]

      DIE_DEFAULTS = {
        explode: ->(attrs)  { attrs[:sides] },
        reroll:  ->(_attrs) { 1 }
      }

      def initialize(count: nil, die:, label: nil)
        self.raw_count = count
        self.raw_die = die
        self.raw_label = label
      end

      def build
        BagOfHolding::Dice::Pool.new count: pool_count,
                                     die: die,
                                     label: raw_label
      end

      private

      attr_accessor :raw_count, :raw_die, :raw_label

      def pool_count
        raw_count.nil? ? 1 : raw_count.to_i
      end

      def die
        BagOfHolding::Dice::Die.new die_attrs
      end

      def die_attrs
        die_options.reduce({}) do |attrs, attr|
          key = attr.keys.first

          if attr.values.first.nil?
            value = DIE_DEFAULTS[key].call(attrs)
          else
            value = attr.values.first.to_i
          end

          attrs.merge(key => value)
        end
      end

      def die_options
        raw_die.select { |attr| DIE_OPTIONS.include? attr.keys.first }
      end
    end
  end
end
