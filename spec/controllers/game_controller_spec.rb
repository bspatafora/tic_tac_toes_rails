require 'rails_helper'
require 'tic_tac_toes/ui/adapter'

describe GameController, :type => :controller do
  describe 'GET #start_game' do
    it 'sends the adapter #start_game' do
      computer_type = "EASY_AI"
      expect(TicTacToes::UI::Adapter).to receive(:start_game)
      get :start_game, { computer_type: computer_type }
    end
  end

  describe 'GET #move' do
    it 'sends the adapter #make_move' do
      board = [nil, nil, nil, nil, nil, nil, nil, nil, nil]
      move = '0'
      computer_type = "EASY_AI"
      expect(TicTacToes::UI::Adapter).to receive(:make_move)
      get :move, { board: board, move: move, computer_type: computer_type }
    end
  end
end
