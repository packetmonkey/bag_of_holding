module BagOfHolding
  module Dice
    # Internal: This class takes the parser output describing a die
    # and builds the correct die object.
    class DieFactory
      def self.build(raw_die:)
        new(raw_die: raw_die).build
      end

      def initialize(raw_die:)
        self.raw_die = raw_die
      end

      def build
        BagOfHolding::Dice::Die.new die_attrs
      end

      private

      DIE_OPTIONS = [:sides, :reroll, :explode]

      DIE_DEFAULTS = {
        explode: ->(attrs)  { attrs[:sides] },
        reroll:  ->(_attrs) { 1 }
      }

      attr_accessor :raw_die

      def die
        BagOfHolding::Dice::Die.new die_attrs
      end

      def die_attrs
        die_options.reduce({}) do |attrs, attr|
          attrs.merge die_attr(attr, attrs)
        end
      end

      def die_attr(attr, attrs)
        name = attr.keys.first

        value = attr.values.first
        value = value.nil? ? DIE_DEFAULTS[name].call(attrs) : value.to_i

        { name => value }
      end

      def die_options
        raw_die.select { |attr| DIE_OPTIONS.include? attr.keys.first }
      end
    end
  end
end
