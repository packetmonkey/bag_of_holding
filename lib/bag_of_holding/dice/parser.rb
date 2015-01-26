require 'parslet'

module BagOfHolding
  module Dice
    # Internal: Parse a string defining a given roll into an ast
    class Parser < Parslet::Parser
      rule(:space)      { match('\s') }
      rule(:space?)     { space.maybe }
      rule(:integer)    { match('[0-9]').repeat(1) }

      rule(:label_text) { match('[^()]').repeat(1).as(:label) }
      rule(:label)      { space? >> str('(') >> label_text >> str(')') }
      rule(:label?)     { label.maybe }

      rule(:exploding)  { str('e') >> integer.maybe.as(:explode) }
      rule(:reroll)     { str('r') >> integer.maybe.as(:reroll) }
      rule(:keep)       { str('k') >> integer.maybe.as(:keep) }
      rule(:option)     { exploding | reroll | keep }
      rule(:options)    { option.repeat }
      rule(:options?)   { options.maybe }

      rule(:sides)      { integer.as(:sides).repeat(1) }

      rule(:die)        { str('d') >> sides >> options? }

      rule(:count)      { integer.as(:count) }
      rule(:count?)     { count.maybe }

      rule(:pool)       { count? >> die.as(:die) >> label? }
      rule(:constant)   { integer.as(:constant) }

      rule(:addition)       { str('+') }
      rule(:subtraction)    { str('-') }
      rule(:division)       { str('/') }
      rule(:multiplication) { str('*') }
      rule(:operators) do
        addition | subtraction | division | multiplication
      end
      rule(:operator)       { operators.as(:operator) >> space? }

      rule(:sum) { value.as(:left) >> operator >> expression.as(:right) }

      rule(:value)        { (pool | constant) >> space? }
      rule(:expression)   { (sum | value) >> str(',').maybe >> space? }
      rule(:expressions)  { expression.repeat(1) }

      root :expressions
    end
  end
end
