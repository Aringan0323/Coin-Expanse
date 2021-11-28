require "binance-ruby"

module OrderApi


  def self.check_orders
    reqire_login
    ENV["BINANCE_API_KEY"] = current_user.binance_public_key
    ENV["BINANCE_SECRET_KEY"] = current_user.encryptedBinanceApiKey
    open_orders = Binance::Api::Order.all_open!
    Binance::Api::Configuration.api_key = nil
    Binance::Api::Configuration.secret_key = nil
    ENV["BINANCE_API_KEY"] = nil
    ENV["BINANCE_SECRET_KEY"] = nil
    open_orders
  end


  def self.account_info(current_user)
    # reqire_login
    ENV["BINANCE_API_KEY"] = current_user.binance_public_key
    ENV["BINANCE_SECRET_KEY"] = current_user.encryptedBinanceApiKey
    info = Binance::Api::Account.info!
    Binance::Api::Configuration.api_key = nil
    Binance::Api::Configuration.secret_key = nil
    ENV["BINANCE_API_KEY"] = nil
    ENV["BINANCE_SECRET_KEY"] = nil
    info
  end


  def self.buy(coin, qty)
    require_login
    ENV["BINANCE_API_KEY"] = current_user.binance_public_key
    ENV["BINANCE_SECRET_KEY"] = current_user.encryptedBinanceApiKey
    buy_response = Binance::Api::Order.create!(
      quantity: qty.to_s,
      side: 'BUY',
      symbol: coin.binance_symbol,
      type: 'MARKET'
    )
    ENV["BINANCE_API_KEY"] = nil
    ENV["BINANCE_SECRET_KEY"] = nil
    buy_response
  end


  def self.sell(coin, qty)
    require_login
    ENV["BINANCE_API_KEY"] = current_user.binance_public_key
    ENV["BINANCE_SECRET_KEY"] = current_user.encryptedBinanceApiKey
    sell_response = Binance::Api::Order.create!(
      quantity: qty.to_s,
      side: 'SELL',
      symbol: coin.binance_symbol,
      type: 'MARKET'
    )
    ENV["BINANCE_API_KEY"] = nil
    ENV["BINANCE_SECRET_KEY"] = nil
    sell_response
  end

  # For testing 


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


  def self.buy_test(coin, qty, user)
    ENV["BINANCE_API_KEY"] = user.binance_public_key
    ENV["BINANCE_SECRET_KEY"] = user.encryptedBinanceApiKey
    buy_response = Binance::Api::Order.create!(
      quantity: qty.to_s,
      side: 'BUY',
      symbol: coin.binance_symbol,
      type: 'MARKET',
      test: "true"
    )
    ENV["BINANCE_API_KEY"] = nil
    ENV["BINANCE_SECRET_KEY"] = nil
    buy_response
  end

  def self.sell_test(coin, qty, user)
    ENV["BINANCE_API_KEY"] = user.binance_public_key
    ENV["BINANCE_SECRET_KEY"] = user.encryptedBinanceApiKey
    sell_response = Binance::Api::Order.create!(
      quantity: qty.to_s,
      side: 'SELL',
      symbol: coin.binance_symbol,
      type: 'MARKET',
      test: "true"
    )
    ENV["BINANCE_API_KEY"] = nil
    ENV["BINANCE_SECRET_KEY"] = nil
    sell_response
  end

end