Rails.application.routes.draw do
  
  root to: "posts#index"
  get '/profile/:id', to: 'users#show', as: 'profile'
  resources :posts do
    collection do
      post :confirm
    end
  end
  
  resources :sessions, only: [:new, :create, :destroy]
  get '/login', to: 'sessions#new', as: 'login'
  get '/register', to: 'users#new', as: 'register'
  resources :users, only: [:new, :create,  :show]
  get '/', to: redirect('/login')
end
