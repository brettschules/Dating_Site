Rails.application.routes.draw do

  root "sessions#index"

  resources :event_users, only: [:new, :create, :destroy]
  resources :events


  resources :users

  get '/signin', to: "sessions#new", as: "login_page"
  post '/signin', to: "sessions#create", as: "new_login"
  delete '/logout', to: "sessions#destroy", as: "logout"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
