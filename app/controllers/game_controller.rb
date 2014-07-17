require 'tic_tac_toes/board'

class GameController < ApplicationController
  def show
    @board = TicTacToes::Board.new.spaces unless @board
  end

  def move
    @board = params[:board]
    @move = params[:move]
    render :show
  end
end
