# frozen_string_literal: true

require './lib/game'
require './lib/board'
require './lib/player'

describe Game do
  describe '#register_player' do
    context 'when registering a player named "Austin"' do
      subject(:reg_game) { described_class.new }
      before do
        player1 = 'Austin'
        allow(reg_game).to receive(:gets).and_return(player1)
        reg_game.register_player
      end

      it 'increases length of @players by 1' do
        expect { reg_game.register_player }.to change { reg_game.players.length }.by(1)
      end

      it 'makes the last item in @players be a Player' do
        expect(reg_game.players.last).to be_a(Player)
      end

      it 'makes last item in @players have the name "Austin"' do
        expect(reg_game.players.last.name).to eq('Austin')
      end
    end
  end

  describe '#determine_starting_player' do
    before :all do
      @starting_player_game = described_class.new
      add_players(@starting_player_game)
    end

    it 'gives @first_player the "O" symbol' do
      expect(@starting_player_game.first_player.symbol).to eq('O')
    end

    it 'gives @second_player the "X" symbol' do
      expect(@starting_player_game.second_player.symbol).to eq('X')
    end
  end

  describe '#check_for_win' do
    context 'when there is a set of winning moves' do
      before :all do
        @won_game = described_class.new
        add_players(@won_game)
      end
      it 'marks @first_player as the winner if win sequence symbol is "O"' do
        first_player_win_moves = %w[O O O _ _ _ _ _ _]
        @won_game.moves = first_player_win_moves
        @won_game.check_for_win
        expect(@won_game.winner).to eq(@won_game.first_player)
      end

      it 'marks @second_player as the winner if win sequence symbol is "X"' do
        second_player_win_moves = %w[X X X _ _ _ _ _ _]
        @won_game.moves = second_player_win_moves
        @won_game.check_for_win
        expect(@won_game.winner).to eq(@won_game.second_player)
      end
    end

    context 'when there is not a set of winning moves' do
      subject(:not_won_game) { described_class.new }
      before do
        blank_board_moves = %w[_ _ _ _ _ _ _ _ _]
        not_won_game.moves = blank_board_moves
      end
      it '@winner is nil' do
        not_won_game.check_for_win
        expect(not_won_game.winner).to be_nil
      end
    end
  end

  describe '#take_turn' do
    before :all do
      @game_play = described_class.new
      add_players(@game_play)
    end

    context 'when it is the first player\'s turn' do
      context 'when first player submits a valid move' do
        it 'does not display an error message' do
          valid_move = '1'
          allow(@game_play).to receive(:gets).and_return(valid_move)
          error_message = 'Invalid selection'
          expect(@game_play).not_to receive(:puts).with(error_message)
          @game_play.take_turn(@game_play.first_player)
        end

        it 'increases turns_taken by 1' do
          valid_move = '2'
          allow(@game_play).to receive(:gets).and_return(valid_move)
          player1 = @game_play.first_player
          expect { @game_play.take_turn(player1) }.to change { player1.turns_taken }.by(1)
        end

        it 'adds the move to the @moves array' do
          valid_move = '3'
          allow(@game_play).to receive(:gets).and_return(valid_move)
          @game_play.take_turn(@game_play.first_player)
          expect(@game_play.moves[2]).to eq('O')
        end
      end

      context 'when first player submits an invalid move then a valid move' do
        it 'displays error message once' do
          invalid_move = 'a'
          valid_move = '4'
          allow(@game_play).to receive(:gets).and_return(invalid_move, valid_move)
          error_message = 'Invalid selection'
          expect(@game_play).to receive(:puts).with(error_message).once
          @game_play.take_turn(@game_play.first_player)
        end
      end
    end
  end

  describe '#play_game' do
    context 'when there is a winner' do
      before do
        @game_win = described_class.new
        add_players(@game_win)
        @game_win.winner = @game_win.first_player
      end

      it 'displays a message showing the winner' do
        player1_win_message = "#{@game_win.first_player.name} wins!"
        expect(@game_win).to receive(:puts).with(player1_win_message)
        @game_win.play_game
      end
    end
  end
end

def add_players(game)
  players = []
  players.push(Player.new('Austin'))
  players.push(Player.new('Bob'))
  game.instance_variable_set(:@players, players)
  game.determine_starting_player
end