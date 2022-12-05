# frozen_string_literal: true

class Game
  attr_accessor :players, :board, :moves, :winner, :first_player,
                :second_player

  WINNING_MOVES = [
    [0, 1, 2], [0, 3, 6], [0, 4, 8],
    [6, 7, 8], [2, 5, 8], [2, 4, 6]
  ].freeze

  def initialize
    @players = []
    @board = Board.new
    @moves = Array.new(9, '_')
    @winner = nil
  end

  def start_game
    2.times { register_player }
    determine_starting_player
    render_board
    play_game
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
      prompt = ', make your move. (Squares are numbered 1-9, left to right)'
      if @first_player.turns_taken == @second_player.turns_taken
        puts @first_player.name + prompt
        take_turn(@first_player)
      else
        puts @second_player.name + prompt
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
      selection = gets.chomp
      if valid_move?(selection)
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

  def check_for_win
    WINNING_MOVES.each do |move|
      if moves_match?(move[0], move[1], move[2])
        @winner = @moves[move[0]] == 'O' ? @first_player : @second_player
        break
      end
    end
  end

  private

  def render_board
    @board.render_board(@moves)
  end

  def valid_move?(selection)
    selection.match(/\A\d\z/) &&
      selection.to_i.positive? &&
      !@moves[selection.to_i - 1].nil? &&
      @moves[selection.to_i - 1] == '_'
  end

  def register_move(move)
    @moves[move[:square]] = move[:player].symbol
    render_board
  end

  def moves_match?(a, b, c)
    @moves[a] != '_' && @moves[a] == @moves[b] && @moves[a] == @moves[c]
  end
end