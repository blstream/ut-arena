# Game Controller Class
class GamesController < ApplicationController

  # Public: Index Action, selects all games, unless offset and size parameters were sent
  def index
    selected_games(Game)
    @games = Game.all
  end

  # Public: Show action, shows the element with specified id
  def show
    @game = Game.find(params[:id])
    @players = @game.players
  end

  # Public: Creates new Game object with parameters from game_params
  def create
    @game = Game.create(game_params)
  end

  # Public: Updates Game object with parameters from game_params
  def update
    @game = Game.find(params[:id])
    @game.update(game_params)
  end

  # Public: Deletes Game object
  def destroy
    @game = Game.find(params[:id])
    @game.destroy
  end

  # Public: Opened games action
  #
  # Returns not started and not finished Games
  def opened
    @games = Game.where("start_date > now() - time_limit * interval '1 MINUTE'")
    render template: "games/index.json.jbuilder"
  end

  # Public: Method that allows user to join the opened game
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

  # Public: Finished games action
  #
  # Returns finished Games
  def finished
    @player = Player.find_by_id(params[:player_id])
    @games = @player.games.where("start_date < now() - time_limit * interval '1 MINUTE'")
  end

  # Public: Player Score in Game
  def player_score
    player = Player.find_by_id(params[:player_id])
    @scores = player.player_games.find_by_game_id(params[:game_id])
  end

  # Public: List of all players that joined the game
  def players
    @players = Game.find_by_id(params[:id]).players
    render template: "players/players.json.jbuilder"
  end

  # Public: Add score to the game
  def add_score
    @score = Player.find_by_id(params[:player_id]).player_games.find_by(game_id: params[:game_id])
    @score.update({ score: params[:score], team: params[:team] })
  end


  private

  # Private: Selected Games method, it is responsible for pagination of the Games
  def selected_games(object)
    offset = params[:offset].to_i
    size = params[:size].to_i
    if (offset  && size) != 0
      @count = object.count
      @games = object.where(id: offset..(offset + size))
      return render template: "games/paginated_games.json.jbuilder"
    end
  end

  # Private: Strong Parameters for the Game object
  def game_params
    params.require(:game).permit(:start_date, :time_limit, :map_name, :match_type)
  end

end
