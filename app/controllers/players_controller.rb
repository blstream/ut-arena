# Player Controller class
class PlayersController < ApplicationController

  # Public: Index Action, selects all players, unless offset and size parameters were sent
  def index
    selected_players(Player)
    @players = Player.all
  end

  private
  
  # Private: Selected Players method, it is responsible for pagination of the Players
  def selected_players(object)
    offset = params[:offset].to_i
    size = params[:size].to_i
    if (offset  && size) != 0
      @count = object.count
      players = object.where(id: offset..(offset + size))
        return render template: "players/paginated_players.json.jbuilder"
      end
    end
end
