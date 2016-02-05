class GamesController < ApplicationController
  def index
    games = Game.all
    render json: games, status: 200
  end

  def show
    game = Game.find(params[:id])
    render json: game,
      except: [:created_at, :updated_at],
      include:
        {
          players:
         {
           only: [:nick, :id],
           include: {
             player_games:
               { only: [:score, :team] }
             }
         }
       },
      status: 200
  end
end
