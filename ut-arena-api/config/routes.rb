Rails.application.routes.draw do

  resources :games, defaults: {format: :json}
  resources :users, defaults: {format: :json}
  resources :sessions, defaults: {format: :json}

end
