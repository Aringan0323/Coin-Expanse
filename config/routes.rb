Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'private_sessions#destroy'
  get 'register', to: 'user#new'
  post 'register', to: 'user#create'

  resources :news_articles
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # GET /
  root to: 'home#index'

  # GET /about
  get '/about', to: 'about#index'

  # paths for coin
  resources :coin

  # private user routes
  get '/account', to: 'user#show'

  # strategies
  get '/strategies/library', to: 'strategies#show'
  get '/strategies/new', to: 'strategies#new'
  post '/strategies/add_card', to: 'strategies#add_card'
  # post '/strategies/new', to: 'strategies#new'
end
