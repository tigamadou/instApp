Rails.application.routes.draw do
  
  get 'errors/not_found'
  get 'errors/internal_server_error'
  root to: "posts#index"
  get '/profile/:id', to: 'users#show', as: 'profile'
  get '/profile/:id/edit', to: 'users#edit', as: 'edit_profile_path'
  resources :posts do
    collection do
      post :confirm
    end
    resources :favorites, only: %i[create destroy]
  end
  
  resources :sessions, only: [:new, :create, :destroy]
  get '/login', to: 'sessions#new', as: 'login'
  get '/register', to: 'users#new', as: 'register'
  resources :users
  get '/', to: redirect('/login')

  get "/404", to: "errors#not_found", via: :all
  get "/500", to: "errors#internal_server_error", via: :all

  resources :favorites, only: [:create, :destroy]
end
