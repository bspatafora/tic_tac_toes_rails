class GameController < ApplicationController
  def show
    TicTacToes::Web::Adapter.new_game_state_json
  end

  def move
  end
end
