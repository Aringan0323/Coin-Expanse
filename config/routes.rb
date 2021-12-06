require 'sidekiq/web'
require 'sidekiq-scheduler/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'private_sessions#destroy'
  get 'register', to: 'user#new'
  post 'register', to: 'user#create'
  get '/order', to: 'order#index'

  resources :passwords
  get "password/forgot", to: 'password#forgot'
  post 'password/forgot', to: 'password#forgot'
  post 'password/reset', to: 'password#reset'
  resources :news_articles
  resources :indicators
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # GET /
  root to: 'home#index'

  # GET /about
  get '/about', to: 'about#index'

  # paths for coin
  resources :coin
  get '/chart_data/avg', to: "coin#chart_avg_data"
  get '/chart_data/ask', to: "coin#chart_ask_data"
  get '/chart_data/bid', to: "coin#chart_bid_data"
  get '/chart_data/price', to: "coin#chart_price_data"

  resources :indicator
  get '/indicator/data', to: "indicator#get_data"


  # private user routes
  get '/account', to: 'user#show'
  get '/account/edit', to: 'user#edit'

  # strategies
  get '/strategies/library', to: 'strategies#show'
  get '/strategies/new', to: 'strategies#new'
  post 'strategies/new', to: 'strategies#create'
  post '/strategies/add_card', to: 'strategies#add_card'
  post '/strategies/delete/:id', to: 'strategies#delete'
  get '/strategies/edit/:id', to: 'strategies#edit'
  post '/strategies/edit/:id', to: 'strategies#update'
  get '/strategies/execute/:id', to: 'strategies#manual_execute'

  # orders
  post '/order', to: 'order#order'
end
