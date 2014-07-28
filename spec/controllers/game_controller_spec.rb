require 'rails_helper'
require 'tic_tac_toes/ui/adapter'

describe GameController, :type => :controller do
  describe 'GET #show' do
    it 'assigns a new board structure to @board if it isn’t passed one' do
      get :show
      expect(assigns(:board)).to eq([nil, nil, nil, nil, nil, nil, nil, nil, nil])
    end
  end

  describe 'GET #move' do
    it 'sends the adapter #make_move with the current board, the user’s move, and itself' do
      board = [nil, nil, nil, nil, nil, nil, nil, nil, nil]
      move = '0'
      expect(TicTacToes::UI::Adapter).to receive(:make_move).with(board, move, controller)
      get :move, { board: board, move: move }
    end
  end
end
