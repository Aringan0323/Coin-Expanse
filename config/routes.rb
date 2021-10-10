Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # GET /
  root to: 'home#index'

  # GET /about
  get '/about', to: 'about#index'

  # GET /supported-cryptos
  get '/supported-cryptos', to: 'supported_cryptos#index'
end
