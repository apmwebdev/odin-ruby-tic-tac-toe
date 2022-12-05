# frozen_string_literal: true

require './lib/board'

describe Board do
  subject(:board) { described_class.new }

  describe '#render_board' do
    it 'renders board from moves array' do
      moves = %w[_ _ _ _ _ _ _ _ _]
      moves_output = "_ _ _\n_ _ _\n_ _ _"
      expect(board).to receive(:puts).with(moves_output)
      board.render_board(moves)
    end
  end
end
