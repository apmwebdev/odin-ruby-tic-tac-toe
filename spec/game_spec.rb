# frozen_string_literal: true

require './lib/game'
require './lib/board'
require './lib/player'

describe Game do
  subject(:game) { described_class.new }

  describe '#register_player' do
    before do
      player1 = 'Austin'
      player2 = 'Bob'
      allow(game).to receive(:gets).and_return(player1, player2)
    end

    it 'increases length of @players by 1' do
      expect { game.send(:register_player) }.to change { game.instance_variable_get(:@players).length }.by(1)
    end
  end
end