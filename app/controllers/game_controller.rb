require 'tic_tac_toes/ui/adapter'
require 'tic_tac_toes/ui/serializer'

class GameController < ApplicationController
  def start_game
    board = TicTacToes::UI::Serializer.new_board_structure
    game_state = TicTacToes::UI::Serializer.game_state_from_board_structure(board,
                                                                            params[:computer_type])
    TicTacToes::UI::Adapter.start_game(params[:order], game_state, self)
  end

  def move
    game_state = TicTacToes::UI::Serializer.game_state_from_board_structure(params[:board],
                                                                            params[:computer_type])
    TicTacToes::UI::Adapter.make_move(game_state, params[:move], self)
  end

  def moves_were_made(game_state)
    @board = TicTacToes::UI::Serializer.board_structure_from_game_state(game_state)
    @computer_type = TicTacToes::UI::Serializer.computer_type_from_game_state(game_state)
    render :board
  end

  def game_ended_in_draw(game_state)
    @board = TicTacToes::UI::Serializer.board_structure_from_game_state(game_state)
    @message = t(:tie_game)
    render :game_is_over
  end

  def game_ended_in_winner(game_state, winning_token)
    @board = TicTacToes::UI::Serializer.board_structure_from_game_state(game_state)
    @message = t(:winner, winning_token: winning_token == 'X' ? t(:X) : t(:O))
    render :game_is_over
  end
end
