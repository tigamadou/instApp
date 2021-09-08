Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/inbox" if Rails.env.development?

  get 'errors/not_found'
  get 'errors/internal_server_error'
  root to: "posts#index"

  resources :profile, controller: 'users', only: %i[show edit] do
    resources :favorites, only: %i[index]   
  end

  resources :posts do
    collection do
      post :confirm
    end
    resources :favorites, only: %i[ create destroy]
    
  end
  
  resources :sessions, only: [:new, :create, :destroy]
  get '/login', to: 'sessions#new', as: 'login'
  get '/register', to: 'users#new', as: 'register'
  resources :users do
    resources :favorites, only: %i[show]
  end
  get '/', to: redirect('/login')

  get "/404", to: "errors#not_found", via: :all
  get "/500", to: "errors#internal_server_error", via: :all

  resources :favorites, only: [:create, :destroy]
end
