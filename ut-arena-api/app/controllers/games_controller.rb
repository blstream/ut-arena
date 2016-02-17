class GamesController < ApplicationController
  def index
    selected_games(Game)
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

  def finished
    @player = Player.find_by_id(params[:player_id])
    @games = @player.games.where("start_date < now() - time_limit * interval '1 MINUTE'")
  end

  def player_score
    player = Player.find_by_id(params[:player_id])
    @scores = player.player_games.find_by_game_id(params[:game_id])
  end

  def players
    @players = Game.find_by_id(params[:id]).players
    render :template => "players/players.json.jbuilder"
  end

  def add_score
    @score = Player.find_by_id(params[:player_id]).player_games.find_by(game_id: params[:game_id])
    @score.update({ score: params[:score], team: params[:team] })
  end

  private
  def selected_games(object)
    skip = params[:skip].to_i
    take = params[:take].to_i
    if (skip  && take) != 0
      @count = object.count
      @games = object.where(id: skip..(skip + take))
      return render :template => "games/paginated_games.json.jbuilder"
    end
  end

  def game_params
    params.require(:game).permit(:start_date, :time_limit, :map_name, :match_type)
  end

end
