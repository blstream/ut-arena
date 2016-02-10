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
  end

  def update
    @game = Game.find(params[:id])
    @game.update(game_params)
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
  end

  def opened
    @games = Game.where("start_date > now() - time_limit * interval '1 MINUTE'")
    render :template => "games/index.json.jbuilder"
  end

  def join
    player_game_params = {game_id: params[:id], player_id: params[:player_id]}
    if Game.find_by_id(params[:id]).is_finished?
      return render json: { error: "This game has already finished and cannot be joined" }, status: 400
    end
    if not(PlayerGame.find_by(player_game_params).nil?)
      return render json: { error: "This user has already joined that game" }, status: 409
    end
    @player_game = PlayerGame.create(player_game_params)
  end

  private

  def game_params
    params.require(:game).permit(:start_date, :time_limit, :map_name, :match_type)
  end

end
