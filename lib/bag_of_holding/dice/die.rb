module BagOfHolding
  module Dice
    # Internal: Represent a physical die and it's attributes
    class Die
      attr_accessor :sides, :reroll, :explode, :errors

      def initialize(opts = {})
        self.sides    = opts[:sides]
        self.explode  = opts[:explode]
        self.reroll   = opts[:reroll]
        self.errors   = {}
      end

      def ==(other)
        return false if sides != other.sides
        return false if explode != other.explode
        return false if reroll != other.reroll

        true
      end

      def roll
        fail StandardError unless valid?
        roll_result
      end

      def valid?
        validate
        errors.empty? ? true : false
      end

      def to_s
        'd'.tap do |str|
          str << sides.to_s
          str << "r#{reroll}" if reroll
          str << "e#{explode}" if explode
        end
      end

      private

      def roll_result
        BagOfHolding::Dice::DieRoller.roll self
      end

      def add_error(field, message)
        errors[field] ||= []
        errors[field].push message
      end

      def validate
        self.errors = {}

        validate_sides
        validate_explosion
        validate_reroll
      end

      def validate_sides
        add_error :sides, "can't be blank" unless sides
      end

      def validate_explosion
        return unless explode

        msg = 'must be higher than reroll'
        add_error :explode, msg if explode <= reroll if reroll
      end

      def validate_reroll
        return unless reroll

        msg = 'must be lower than explode'
        add_error :reroll, msg if reroll >= explode if explode
      end
    end
  end
end
