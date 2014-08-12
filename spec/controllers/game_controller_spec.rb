require 'rails_helper'
require 'tic_tac_toes/ui/adapter'
require 'tic_tac_toes/ui/serializer'

describe GameController, :type => :controller do
  describe 'GET #start_game' do
    it 'sends the adapter #start_game' do
      computer_type = 'EASY_AI'
      order = 'first'
      game_state = double
      allow(TicTacToes::UI::Serializer).to receive(:game_state_from_board_structure) { game_state }

      expect(TicTacToes::UI::Adapter).to receive(:start_game).with(order, game_state, GameController)
      get :start_game, { computer_type: computer_type, order: order }
    end
  end

  describe 'GET #move' do
    it 'sends the adapter #make_move' do
      board = [nil, nil, nil, nil, nil, nil, nil, nil, nil]
      move = '0'
      computer_type = 'EASY_AI'
      game_state = double
      allow(TicTacToes::UI::Serializer).to receive(:game_state_from_board_structure) { game_state }

      expect(TicTacToes::UI::Adapter).to receive(:make_move).with(game_state, move, GameController)
      get :move, { board: board, move: move, computer_type: computer_type }
    end
  end
end
