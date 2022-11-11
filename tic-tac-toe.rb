module TicTacToe
  class Game
    def initialize
      @players = []
      @board = TicTacToe::Board.new
      @moves = []
      @winner = false
    end

    def start_game
      9.times { @moves.push('_') }
      2.times { register_player }
      determine_starting_player
      render_board
      play_game
    end

    private

    def render_board
      @board.render_board(@moves)
    end

    def register_player
      puts 'Enter player name'
      @players.push(Player.new(gets.chomp))
    end

    def determine_starting_player
      @first_player = @players[rand(2)]
      @first_player.goes_first = true
      @second_player = @players.select { |player| player.goes_first == false }[0]
      @first_player.symbol = 'O'
      @second_player.symbol = 'X'
      puts "#{@first_player.name} goes first."
    end

    def play_game
      until @winner
        if @first_player.turns_taken == @second_player.turns_taken
          take_turn(@first_player)
        else
          take_turn(@second_player)
        end
        check_for_win
      end
      puts "#{@winner.name} wins!"
    end

    def take_turn(player)
      move = { player: player, square: nil }
      move_is_valid = false
      until move_is_valid
        puts "#{player.name}, make your move. (Squares are numbered 1-9, left to right)"
        selection = gets.chomp
        if selection.match(/\A\d\z/) && selection.to_i.positive? &&
           !@moves[selection.to_i - 1].nil? && @moves[selection.to_i - 1] == '_'
          selection = selection.to_i - 1
          move[:square] = selection
          move_is_valid = true
          player.turns_taken += 1
          register_move(move)
        else
          puts 'Invalid selection'
        end
      end
    end

    def register_move(move)
      @moves[move[:square]] = move[:player].symbol
      render_board
    end

    def check_for_win
      if moves_match(0, 1, 2) || moves_match(0, 3, 6) || moves_match(0, 4, 8)
        @winner = @moves[0] == 'O' ? @first_player : @second_player
      elsif moves_match(6, 7, 8) || moves_match(2, 5, 8)
        @winner = @moves[8] == 'O' ? @first_player : @second_player
      elsif moves_match(2, 4, 6)
        @winner = @moves[2] == 'O' ? @first_player : @second_player
      end
    end
    
    def moves_match(a, b, c)
      @moves[a] != '_' && @moves[a] == @moves[b] && @moves[a] == @moves[c]
    end
  end

  class Board
    attr_accessor :moves

    def render_board(moves)
      row1 = moves[0..2].join(' ')
      row2 = moves[3..5].join(' ')
      row3 = moves[6..8].join(' ')
      puts "#{row1}\n#{row2}\n#{row3}"
    end
  end

  class Player
    attr_accessor :name, :goes_first, :turns_taken, :is_winner, :symbol

    def initialize(name)
      @name = name
      @goes_first = false
      @turns_taken = 0
      @is_winner = false
      @symbol = ''
    end

    def to_s
      "name: #{name}, goes_first: #{goes_first}, turns_taken: #{turns_taken}, is_winner: #{is_winner}"
    end
  end
end

game = TicTacToe::Game.new
game.start_game