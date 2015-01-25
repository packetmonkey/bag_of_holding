module BagOfHolding
  module Dice
    # Internal: Represent a physical die and it's attributes
    class Die
      attr_accessor :sides, :reroll, :explode

      def initialize(opts = {})
        self.sides    = opts[:sides]
        self.explode  = opts[:explode]
        self.reroll   = opts[:reroll]
      end

      def ==(other)
        return false if sides != other.sides
        return false if explode != other.explode
        return false if reroll != other.reroll

        true
      end

      def roll
        fail StandardError unless valid?
        BagOfHolding::Dice::DieRoller.roll self
      end

      def valid?
        DieValidator.valid? self
      end

      def to_s
        'd'.tap do |str|
          str << sides.to_s
          str << "r#{reroll}" if reroll
          str << "e#{explode}" if explode
        end
      end
    end
  end
end
