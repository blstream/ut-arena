class PlayersController < ApplicationController
  def index
    selected_players(Player)
    @players = Player.all
  end

  private
  def selected_players(object)
      skip = params[:skip].to_i
      take = params[:take].to_i
      if (skip  && take) != 0
        @count = object.count
        @games = object.where(id: skip..(skip + take))
        return render :template => "players/paginated_players.json.jbuilder"
      end
    end
end
