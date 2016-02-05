Rails.application.routes.draw do

  resources :games, defaults: {format: :json}

end
