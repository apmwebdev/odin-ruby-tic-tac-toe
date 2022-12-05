# frozen_string_literal: true

require './lib/player'

describe Player do
  subject(:player) { described_class.new('Austin') }

  describe '#to_s' do
    it 'displays the player fields in a string' do
      player.goes_first = true
      output = 'name: Austin, goes_first: true, turns_taken: 0, is_winner: false'
      expect(player.to_s).to eq(output)
    end
  end
end