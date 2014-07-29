require 'rails_helper'
require 'tic_tac_toes/ui/adapter'

describe GameController, :type => :controller do
  describe 'GET #board' do
    it 'assigns a new board structure to @board if it isn’t passed one' do
      get :board
      expect(assigns(:board)).to eq([nil, nil, nil, nil, nil, nil, nil, nil, nil])
    end
  end

  describe 'GET #move' do
    it 'sends the adapter #make_move' do
      board = [nil, nil, nil, nil, nil, nil, nil, nil, nil]
      move = '0'
      expect(TicTacToes::UI::Adapter).to receive(:make_move)
      get :move, { board: board, move: move }
    end
  end
end
