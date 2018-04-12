Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#welcome'

  get 'users/signup' => 'users#new'
  post '/users' => 'users#create'
  get 'users/welcome' => 'users#welcome'
  get 'sessions/login' => 'sessions#login'
  post 'sessions/create' => 'sessions#create'
end
