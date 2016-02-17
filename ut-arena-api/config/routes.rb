Rails.application.routes.draw do

  post '/games/:id/join', to: 'games#join', as: 'join_game'
  patch '/games/:game_id/players/:player_id/scores', to: 'games#add_score', as: 'add_score'
  get '/games/:game_id/players/:player_id', to: 'games#player_score', as: "player_score"
  get '/games/:id/players', to: 'games#players', as: 'game_players'
  get '/games/finished', to: 'games#finished', as: 'finished'
  get '/games/opened', to: 'games#opened', as: 'opened'
  resources :games, defaults: {format: :json}
  resources :users, defaults: {format: :json}
  resources :sessions, defaults: {format: :json}
  resources :players, defaults: {format: :json}
end
