Rails.application.routes.draw do

  resources :games, defaults: {format: :json}
  resources :users, defaults: {format: :json}

end
