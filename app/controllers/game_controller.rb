require 'tic_tac_toes/ui/adapter'
require 'tic_tac_toes/ui/serializer'

class GameController < ApplicationController
  def choose_order
    @board = TicTacToes::UI::Serializer.new_board_structure
  end

  def board
    @board = TicTacToes::UI::Serializer.new_board_structure unless @board
  end

  def move
    game_state = TicTacToes::UI::Serializer.game_state_from_board_structure(params[:board])
    TicTacToes::UI::Adapter.make_move(game_state, params[:move], self)
  end

  def moves_were_made(game_state)
    @board = TicTacToes::UI::Serializer.game_state_to_board_structure(game_state)
    render :board
  end

  def game_ended_in_draw(game_state)
    @board = TicTacToes::UI::Serializer.game_state_to_board_structure(game_state)
    @message = 'Tie game.'
    render :game_is_over
  end

  def game_ended_in_winner(game_state, winning_token)
    @board = TicTacToes::UI::Serializer.game_state_to_board_structure(game_state)
    @message = "#{winning_token} wins!"
    render :game_is_over
  end
end
