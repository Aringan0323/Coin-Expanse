require "binance-ruby"
require 'httparty'

module OrderApi 

  include ApiUtils
  include HTTParty
  def self.check_orders
    ENV["BINANCE_API_KEY"] = current_user.binance_public_key
    ENV["BINANCE_SECRET_KEY"] = current_user.encryptedBinanceApiKey
    open_orders = Binance::Api::Order.all_open!
    Binance::Api::Configuration.api_key = nil
    Binance::Api::Configuration.secret_key = nil
    ENV["BINANCE_API_KEY"] = nil
    ENV["BINANCE_SECRET_KEY"] = nil
    open_orders
  end


  def self.account_info(user)
    # reqire_login
    ENV["BINANCE_API_KEY"] = user.binance_public_key
    ENV["BINANCE_SECRET_KEY"] = user.encryptedBinanceApiKey
    info = Binance::Api::Account.info!
    Binance::Api::Configuration.api_key = nil
    Binance::Api::Configuration.secret_key = nil
    ENV["BINANCE_API_KEY"] = nil
    ENV["BINANCE_SECRET_KEY"] = nil
    info
  end


  def self.buy(user, coin, qty)

    puts qty.to_s
    puts coin.binance_symbol

    params = {
      "quantity" => qty.to_s,
      "side"=> 'BUY',
      "symbol" => coin.binance_symbol,
      "type" => 'MARKET'
  }

    puts self.binance_order_req(params, user.binance_public_key, user.encryptedBinanceApiKey)
  end


  def self.sell(user, coin, qty)
    puts qty.to_s
    puts coin.binance_symbol
    params = {
      "quantity" => qty.to_s,
      "side"=> 'SELL',
      "symbol" => coin.binance_symbol,
      "type" => 'MARKET'
  }

    puts self.binance_order_req(params, user.binance_public_key, user.encryptedBinanceApiKey)
  end



  def self.check_orders(user)
    ENV["BINANCE_API_KEY"] = user.binance_public_key
    ENV["BINANCE_SECRET_KEY"] = user.encryptedBinanceApiKey
    open_orders = Binance::Api::Order.all_open!
    Binance::Api::Configuration.api_key = nil
    Binance::Api::Configuration.secret_key = nil
    ENV["BINANCE_API_KEY"] = nil
    ENV["BINANCE_SECRET_KEY"] = nil
    open_orders
  end

  def self.binance_order_req(params, api_key, secret_key)
    fixie = URI.parse ENV['FIXIE_URL']
    params['timestamp'] = ApiUtils.timestamp
    params['signature'] = ApiUtils.signed_request_signature(params, secret_key)
    response = post(
      "https://api.binance.us/api/v3/order", 
      query: params, 
      headers: ApiUtils.key_header(api_key), 
      http_proxyaddr: fixie.host,
      http_proxyport: fixie.port,
      http_proxyuser: fixie.user,
      http_proxypass: fixie.password
    )
    response
  end

end