module BagOfHolding
  module Dice
    # Internal: contains the results of a rolled pool and the die rolls that
    # got us there.
    class PoolResult
      attr_accessor :die_results, :value, :pool

      def initialize(die_results: nil, value: nil, pool: nil)
        self.die_results = die_results
        self.value = value
        self.pool = pool
      end

      def ==(other)
        return false if value != other.value
        return false if die_results != other.die_results
        return false if pool != other.pool

        true
      end

      def to_s
        "#{value} (#{pool})"
      end

      def inspect
        "#{value} (#{pool})".tap do |str|
          die_results.each do |die_result|
            die_result.rolls.each do |roll|
              str << " [#{roll}]"
            end
          end
        end
      end
    end
  end
end
