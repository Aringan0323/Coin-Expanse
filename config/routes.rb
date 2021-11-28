Rails.application.routes.draw do
  # mount ActionCable.server, at: '/cable'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'private_sessions#destroy'
  get 'register', to: 'user#new'
  post 'register', to: 'user#create'
  get '/order', to: 'order#index'
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

end
