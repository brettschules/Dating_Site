Rails.application.routes.draw do


  root "sessions#index"

  get '/about', to: "sessions#about", as: "about"

  resources :event_users, only: [:new, :create]

  delete '/event_users/delete', to: "event_users#destroy", as: "delete_rsvp"
  get '/events/names', to: "events#index_name", as: "event_name_sort"
  get '/events/categories', to: "events#index_category", as: "event_category_sort"
  resources :events

  delete '/events/:id', to: "events#destroy", as: "delete_event"


  resources :users, except: [:destroy]
  get 'myliked', to: "users#myliked", as: "my_liked"
  get 'mylikes', to: "users#mylikes", as: "my_likes"
  get 'mymatches', to: "users#mymatches", as: "my_matches"
  delete 'users/:id/delete', to: "users#destroy", as: "delete_user"


  resources :matches, only: [:new, :create, :destroy]




  get '/signin', to: "sessions#new", as: "login_page"
  post '/signin', to: "sessions#create", as: "new_login"
  delete '/logout', to: "sessions#destroy", as: "logout"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
