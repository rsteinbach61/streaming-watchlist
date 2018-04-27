Rails.application.routes.draw do

  resources :shows
  resources :watchlists
  resources :users, only: [:show, :new, :create, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#welcome'
  get 'users/welcome' => 'users#welcome'
  get 'sessions/sign_in' => 'sessions#new'
  post 'sessions/create' => 'sessions#create'
  get "sessions/destroy" => 'sessions#destroy'
end
