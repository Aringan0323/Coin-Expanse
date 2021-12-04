Rails.application.routes.draw do
  # mount ActionCable.server, at: '/cable'
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
  #post '/buyorder' to: 'order#buy'
  #post '/sellorder' to: 'order#sell'
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
  # post '/strategies/new', to: 'strategies#new'

  # orders
  post '/order', to: 'order#order'
end
