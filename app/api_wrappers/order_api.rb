require "binance-ruby"
require 'httparty'

module OrderApi 

  include ApiUtils
  include HTTParty


  def self.buy(user, coin, qty)

    puts qty.to_s
    puts coin.binance_symbol

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
    puts qty.to_s
    puts coin.binance_symbol
    params = {
      "quantity" => qty.to_s,
      "side"=> 'SELL',
      "symbol" => coin.binance_symbol,
      "type" => 'MARKET'
    }

    res = self.binance_order_req(params, user.binance_public_key, user.encryptedBinanceApiKey)
    if res.success?
      Order.create(symbol: coin.binance_symbol, amount: qty, side: "BUY", user: user)
    end
    res
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