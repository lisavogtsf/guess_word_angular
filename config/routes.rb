Rails.application.routes.draw do

  resources :games, except: [:new, :edit]

  match "*path", to: "games#index", via: "get"

  root "games#index"

end
