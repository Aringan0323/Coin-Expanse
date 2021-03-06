require "binance-ruby"
require 'httparty'

module OrderApi 

  include ApiUtils
  include HTTParty


  def self.buy(user, coin, qty)
    params = {
      "quantity" => qty.to_s,
      "side"=> 'BUY',
      "symbol" => coin.binance_symbol,
      "type" => 'MARKET'
    }
    res = self.binance_order_req(params, user.binance_public_key, user.encryptedBinanceApiKey)
    if res.success?
      Order.create(symbol: coin.binance_symbol, amount: qty, side: "BUY", user: user)
    end
    res
  end


  def self.sell(user, coin, qty)
    params = {
      "quantity" => qty.to_s,
      "side"=> 'SELL',
      "symbol" => coin.binance_symbol,
      "type" => 'MARKET'
    }

    res = self.binance_order_req(params, user.binance_public_key, user.encryptedBinanceApiKey)
    if res.success?
      Order.create(symbol: coin.binance_symbol, amount: qty, side: "SELL", user: user)
    end
    res
  end

  def self.binance_order_req(params, api_key, secret_key)
    fixie = URI.parse ENV['FIXIE_URL']
    params['timestamp'] = ApiUtils.timestamp
    params['signature'] = ApiUtils.signed_request_signature(params, secret_key)
    if Rails.env.production?
      response = post(
        "https://api.binance.us/api/v3/order", 
        query: params, 
        headers: ApiUtils.key_header(api_key), 
        http_proxyaddr: fixie.host,
        http_proxyport: fixie.port,
        http_proxyuser: fixie.user,
        http_proxypass: fixie.password
      )
    else
      response = post(
        "https://api.binance.us/api/v3/order", 
        query: params, 
        headers: ApiUtils.key_header(api_key)
      )
    end
    response
  end

end