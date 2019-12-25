class Api::V1::GamesController < ApplicationController
  def index
    games = Game.all

    render json: Panko::ArraySerializer.new(games, each_serializer: Api::V1::GamesSerializer).to_json
  end

  def create
    @game = Game.new(game_params)

    if @game.save

      # Response by MoveFinder
      game.make_a_move!

      render json: { location: api_v1_game_url(@game.id) }, status: 201, location: api_v1_game_url(@game.id)
    else
      render json: { errors: @game.errors.messages }, status: :bad_request
    end
  end

  def show
    render json: Api::V1::GamesSerializer.new.serialize(game)
  end

  def update
    if game.update(game_params)

      # Response by MoveFinder
      game.make_a_move!

      render json: Api::V1::GamesSerializer.new.serialize(game)
    else
      render json: { errors: game.errors.messages }, status: :bad_request
    end
  end

  def destroy
    game.destroy

    head :ok
  end

  def game
    @game ||= Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:board)
  end
end
