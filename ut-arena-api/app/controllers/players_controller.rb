class PlayersController < ApplicationController
  def index
    @players = Player.all
    render :template => "players/players.json.jbuilder"
  end
end
