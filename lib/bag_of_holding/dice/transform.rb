require 'parslet'

module BagOfHolding
  module Dice
    # Internal: Transform a parsed dice string into a callable structure
    class Transform < Parslet::Transform
      rule(constant: simple(:value)) do |dict|
        build_const value: dict[:value]
      end

      # Dice pool with count, without label
      rule(count: simple(:count), die: subtree(:die)) do |dict|
        build_pool count: dict[:count], die: dict[:die]
      end

      # Dice pool without a count, without label
      rule(die: subtree(:die)) do |dict|
        build_pool die: dict[:die]
      end

      # Dice pool with count, label
      rule(
        count: simple(:count), die: subtree(:die), label: simple(:label)
      ) do |dict|
        build_pool count: dict[:count],
                   die: dict[:die],
                   label: dict[:label]
      end

      rule(
        left: simple(:left), operator: simple(:operator), right: simple(:right)
      ) do |dict|
        build_operation left: dict[:left],
                        operator: dict[:operator],
                        right: dict[:right]
      end

      def self.build_operation(left:, operator:, right:)
        operations = [
          AdditionOperation, SubtractionOperation,
          DivisionOperation, MultiplicationOperation
        ]

        operations.find { |o| o.operator == operator }.new left: left,
                                                           right: right
      end

      def self.build_const(value:)
        BagOfHolding::Dice::Constant.new value: Integer(value)
      end

      def self.build_pool(count: nil, die:, label: nil)
        BagOfHolding::Dice::PoolFactory.build count: count,
                                              die: die,
                                              label: label
      end
    end
  end
end
