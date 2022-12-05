# frozen_string_literal: true

class Board
  attr_accessor :moves

  def render_board(moves)
    row1 = moves[0..2].join(' ')
    row2 = moves[3..5].join(' ')
    row3 = moves[6..8].join(' ')
    puts "#{row1}\n#{row2}\n#{row3}"
  end
end
