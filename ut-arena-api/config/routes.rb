Rails.application.routes.draw do

  post '/games/:id/join', to: 'games#join', as: 'join_game'
  get '/games/opened', to: 'games#opened', as: 'opened'
  resources :games, defaults: {format: :json}
  resources :users, defaults: {format: :json}
  resources :sessions, defaults: {format: :json}
end
