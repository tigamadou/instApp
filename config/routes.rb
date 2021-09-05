Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  get '/login', to: 'sessions#new', as: 'login'
  get '/register', to: 'users#new', as: 'register'
  resources :users, only: [:new, :create,  :show]
end
