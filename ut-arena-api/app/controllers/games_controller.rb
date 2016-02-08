class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
    @players = @game.players
  end

  def create
    @game = Game.create(game_params)
    @game.save
  end

  def update
    @game = Game.find(params[:id])
    @game.update(game_params)
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
  end

  private

  def game_params
    params.require(:game).permit(:start_date, :time_limit, :map_name, :match_type)
  end

end
