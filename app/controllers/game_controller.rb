require 'tic_tac_toes/ui/adapter'

class GameController < ApplicationController
  def show
    @board = TicTacToes::UI::Adapter.new_board_structure unless @board
  end

  def move
    TicTacToes::UI::Adapter.make_move(params[:board], params[:move], self)
  end

  def move_was_valid(board_structure)
    @board = board_structure
    render :show
  end

  def game_is_over(board_structure, message)
    @board = board_structure
    @message = message
    render :game_is_over
  end
end
