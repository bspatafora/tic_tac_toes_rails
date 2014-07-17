require 'ui/adapter'

class GameController < ApplicationController
  def show
    @board = UI::Adapter.new_board_structure unless @board
  end

  def move
    @board = UI::Adapter.move_made(params[:board], params[:move])
    render :show
  end
end
