class PlayersController < ApplicationController
  def index
    skip = params[:skip].to_i
    take = params[:take].to_i
    puts params, skip, take
    if (skip  && take) != 0
      @count = Player.count
      @games = Player.where(id: skip..(skip + take))
      return render :template => "players/paginated_players.json.jbuilder"
    end
    @players = Player.all
  end
end
