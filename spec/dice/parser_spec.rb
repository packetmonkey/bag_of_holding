RSpec.describe BagOfHolding::Dice::Parser do
  subject { BagOfHolding::Dice::Parser.new }

  describe '#parse' do
    it 'parses 5' do
      tree = subject.parse '5'
      expect(tree).to match(
        [constant: '5']
      )
    end

    it 'parses 1d20' do
      tree = subject.parse '1d20'
      expect(tree).to match([
        { count: '1', die: [{ sides: '20' }] }
      ])
    end

    it 'parses 1d20,1d8' do
      tree = subject.parse '1d20,1d8'
      expect(tree).to match(
        [
          { count: '1', die: [{ sides: '20' }] },
          { count: '1', die: [{ sides: '8' }] }
        ]
      )
    end

    it 'parses d20' do
      tree = subject.parse 'd20'
      expect(tree).to match([
        die: [{ sides: '20' }]
      ])
    end

    it 'parses 3d8 (Attack)' do
      tree = subject.parse '3d8 (Attack)'
      expect(tree).to match([
        { count: '3', die: [{ sides: '8' }], label: 'Attack' }
      ])
    end

    it 'parses 1d20r' do
      tree = subject.parse '1d20r'
      expect(tree).to match([
        { count: '1', die: [{ sides: '20' }, { reroll: nil }] }
      ])
    end

    it 'parses 5+6' do
      tree = subject.parse '5+6'
      expect(tree).to match([
        { left: { constant: '5' }, operator: '+', right: { constant: '6' } }
      ])
    end

    it 'parses 8, 9' do
      tree = subject.parse '8, 9'
      expect(tree).to match([
        { constant: '8' },
        { constant: '9' }
      ])
    end

    it 'parses 1 + 2, 3' do
      tree = subject.parse('1 + 2, 3')
      expect(tree).to match([
        { left: { constant: '1' }, operator: '+', right: { constant: '2' } },
        { constant: '3' }
      ])
    end

    it 'parses 1d20r (Defense)' do
      tree = subject.parse('1d20r (Defense)')
      expect(tree).to match([
        {
          count: '1',
          die: [
            { sides: '20' },
            { reroll: nil }
          ],
          label: 'Defense' }
      ])
    end

    it 'parses 1d20r2' do
      tree = subject.parse('1d20r2')
      expect(tree).to match([
        { count: '1', die: [{ sides: '20' }, { reroll: '2' }] }
      ])
    end

    it 'parses 1d20e' do
      tree = subject.parse('1d20e')
      expect(tree).to match([
        { count: '1', die: [{ sides: '20' }, { explode: nil }] }
      ])
    end

    it 'parses 1d20e18' do
      tree = subject.parse('1d20e18')
      expect(tree).to match([
        { count: '1', die: [{ sides: '20' }, { explode: '18' }] }
      ])
    end

    it 'parses 1d20e18r2' do
      tree = subject.parse('1d20e18r2')
      expect(tree).to match([
        {
          count: '1',
          die: [
            { sides:   '20' },
            { explode: '18' },
            { reroll:  '2'  }
          ]
        }
      ])
    end

    it 'parses 1d20r2e18' do
      tree = subject.parse('1d20r2e18')
      expect(tree).to match([
        {
          count: '1',
          die: [
            { sides:   '20' },
            { reroll:  '2'  },
            { explode: '18' }
          ]
        }
      ])
    end

    it 'parses 1d20 + 5' do
      tree = subject.parse('1d20 + 5')
      expect(tree).to match([
        {
          left: {
            count: '1',
            die: [
              { sides: '20' }
            ]
          },
          operator: '+',
          right: {
            constant: '5'
          }
        }
      ])
    end

    it 'parses 2d6+ 1d4 + 2' do
      tree = subject.parse('2d6+ 1d4 + 2')
      expect(tree).to match([
        {
          left: {
            count: '2',
            die: [
              { sides: '6' }
            ]
          },
          operator: '+',
          right: {
            left: {
              count: '1',
              die: [
                { sides: '4' }
              ]
            },
            operator: '+',
            right: {
              constant: '2'
            }
          }
        }
      ])
    end
  end
end
