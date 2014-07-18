require 'ui/adapter'

class GameController < ApplicationController
  def show
    @board = UI::Adapter.new_board_structure unless @board
  end

  def move
    UI::Adapter.move_made(params[:board], params[:move], self)
  end

  def valid(board_structure)
    @board = board_structure
    render :show
  end

  def game_over(board_structure, message)
    @board = board_structure
    @message = message
    render :game_over
  end
end
