Rails.application.routes.draw do
  #get 'watchlists/new'
  #patch 'watchlists/new' => 'watchlists#update'
  #get 'watchlists/:id/edit' => 'watchlist#edit'

  #get 'watchlists/show'

  #post 'watchlists/new' => 'watchlists#create'
  resources :watchlists 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#welcome'
  get 'users/show' => 'users#show'
  get 'users/signup' => 'users#new'
  post '/users' => 'users#create'
  get 'users/welcome' => 'users#welcome'
  get 'sessions/sign_in' => 'sessions#new'
  post 'sessions/create' => 'sessions#create'
  get "sessions/destroy" => 'sessions#destroy'
end
