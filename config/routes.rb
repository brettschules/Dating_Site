Rails.application.routes.draw do

  root "sessions#index"

  resources :event_users, only: [:new, :create]
  get '/events/names', to: "events#index_name", as: "event_name_sort"
  get '/events/categories', to: "events#index_category", as: "event_category_sort"
  resources :events

  delete '/events/:id', to:"events#destroy", as: "delete_event"


  resources :users


  get '/signin', to: "sessions#new", as: "login_page"
  post '/signin', to: "sessions#create", as: "new_login"
  delete '/logout', to: "sessions#destroy", as: "logout"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
