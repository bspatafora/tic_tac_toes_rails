require 'json'
require 'tic_tac_toes/core/presenter'
require 'tic_tac_toes/database/pg_wrapper'
require 'tic_tac_toes/ui/adapter'
require 'tic_tac_toes/ui/serializer'

class GameController < ApplicationController
  def start_game
    if params[:ai_type] && params[:order]
      game_state = TicTacToes::UI::Serializer.game_state(TicTacToes::UI::Serializer.new_board_structure,
                                                         params[:ai_type],
                                                         nil,
                                                         'unused_connection')
      TicTacToes::UI::Adapter.start_game(params[:order], game_state, self)
    else
      flash.now[:alert] = translate(:incomplete_form_alert)
      render :settings
    end
  end

  def move
    connection = PG.connect(dbname: ENV['TTT_DATABASE'],
                            host: ENV['TTT_HOST'],
                            port: ENV['TTT_PORT'],
                            user: ENV['TTT_USER'],
                            password: ENV['TTT_PASSWORD'])
    game_state = TicTacToes::UI::Serializer.game_state(params[:board],
                                                       params[:ai_type],
                                                       params[:move_history],
                                                       connection)
    TicTacToes::UI::Adapter.make_move(game_state, params[:move], self)
  end

  def game_history
    connection = PG.connect(dbname: ENV['TTT_DATABASE'],
                            host: ENV['TTT_HOST'],
                            port: ENV['TTT_PORT'],
                            user: ENV['TTT_USER'],
                            password: ENV['TTT_PASSWORD'])
    storage_wrapper = TicTacToes::Database::PGWrapper.new(connection)
    presenter = TicTacToes::Core::Presenter
    @game_history = presenter.game_history_strings(storage_wrapper)
  end

  def moves_were_made(game_state)
    @board = TicTacToes::UI::Serializer.board_structure(game_state)
    @ai_type = TicTacToes::UI::Serializer.ai_type(game_state)
    @move_history = TicTacToes::UI::Serializer.move_history(game_state)
    @predictions = JSON.generate({ spaces: TicTacToes::UI::Adapter.predictions(game_state) })
    render :board
  end

  def game_ended_in_draw(game_state)
    @board = TicTacToes::UI::Serializer.board_structure(game_state)
    @message = translate(:tie_game)
    render :game_is_over
  end

  def game_ended_in_winner(game_state, winning_token)
    @board = TicTacToes::UI::Serializer.board_structure(game_state)
    @message = translate(:winner, winning_token: winning_token == 'X' ? translate(:X) : translate(:O))
    render :game_is_over
  end
end
