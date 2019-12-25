require 'rails_helper'

RSpec.describe Api::V1::GamesController, type: :controller do
  describe '#index' do
    before do
      create_list :game, 5
    end

    it 'gets list of games' do
      get :index

      expect(json_response.map{|game| game['id']}).to include(*Game.all.ids)
    end
  end

  describe '#show' do
    let(:game) { create :game }

    it 'loads game by uuid' do
      get :show, params: { id: game.id }

      expect(json_response['board']).to eql game.board
    end
  end

  describe '#create' do
    it 'creates new game' do
      expect do
        post :create, params: { game: { board: '----X----' } }
      end.to change(Game, :count).by(1)
    end
  end

  describe '#update' do
    let(:game) { create :game, board: '---------' }

    it 'updates ands makes a move' do
      old_board_state = 'X--------'

      put :update, params: { id: game.id, game: { board: 'X--------' } }

      expect(json_response['board'].first).to eql('X')
      expect(json_response['board']).not_to eq(old_board_state)
    end
  end

  describe '#destroy' do
    let!(:game) { create :game }

    it 'removes a game' do
      expect do
        delete :destroy, params: { id: game.id }
      end.to change(Game, :count).by(-1)
    end
  end
end
