require "./app/api_wrappers/api_utils.rb"
require "json"


module MarketApi

  # Hash that maps the symbol (base asset, not binance symbol) of each coin to the name of the coin
  json_file = File.read("./db/seed_data/symbol_to_name.json")
  @symbol_to_name = JSON.parse(json_file)

  

  # Creates a hash mapping the binance symbols of Coins to their ids
  def self.coin_id_map(coins)
      
    id_map = {}
    coins.each do |coin|
      id_map[coin.binance_symbol] = coin.id
    end

    id_map
  end

  # Accepts as input a list of hashes and returns a hash mapping the "symbol" field of each hash
  # to the hash itself
  def self.label_hash_list(hash_list)

    labeled_hash_list = {}

    hash_list.each do |hash|
      labeled_hash_list[hash["symbol"]] = hash
    end

    labeled_hash_list
  end


  def self.create_coin(symbol_info_hash)
    coin = Coin.new
    coin.symbol = symbol_info_hash["baseAsset"]
    coin.binance_symbol = symbol_info_hash["symbol"]
    coin.name = symbol_to_name[coin.symbol]

    coin
  end



  # Creates and returns a new BookTicker ActiveRecord from an avg_price hash, a bticker hash, and a coin id
  def self.create_book_ticker(avg_price_hash, bticker_hash, coin_id)

    book_ticker = BookTicker.new(
      avgPrice: avg_price_hash["price"],
      bidPrice: bticker_hash["bidPrice"],
      bidQty: bticker_hash["bidQty"],
      askPrice: bticker_hash["askPrice"],
      askQty: bticker_hash["askQty"],
      timestamp: DateTime.now(),
      coin_id: coin_id
    )

    book_ticker
  end

  
  # Returns a list of new Coin ApplicationRecords
  def self.get_all_coins

    info = ApiUtils.get_api_res("https://api.binance.us/api/v3/exchangeInfo")

    taapi_coins = ["BTC", "ETH", "XRP", "LTC", "XMR"]

    coins = []

    if info.nil?
      nil
    else
      symbols_info = info["symbols"]
      symbols_info.each do |symbol_info|

        spot = symbol_info["isSpotTradingAllowed"] && (taapi_coins.include? symbol_info["baseAsset"])
        has_usd_conversion = symbol_info["quoteAsset"] == "USD"
        
        if spot && has_usd_conversion

          coin = Coin.new
          coin.symbol = symbol_info["baseAsset"]
          coin.binance_symbol = symbol_info["symbol"]
          coin.name = @symbol_to_name[coin.symbol]

          coins << coin
        end
      end

      coins
    end
  end


  # Returns a list of new BookTicker ApplicationRecords from a list of Coin ApplicationRecords which
  # have been saved to the database
  def self.book_tickers(coins)

    avg_prices_list = ApiUtils.get_api_res("https://api.binance.us/api/v3/ticker/price")
    btickers_list = ApiUtils.get_api_res("https://api.binance.us/api/v3/ticker/bookTicker")

    if avg_prices_list.nil? or btickers_list.nil?
      nil
    else
      avg_prices = label_hash_list(avg_prices_list)
      btickers = label_hash_list(btickers_list)

      book_ticker_list = []

      coins.each do |coin|

        if btickers.key?(coin.binance_symbol) and avg_prices.key?(coin.binance_symbol)
          new_bt = create_book_ticker(
            avg_prices[coin.binance_symbol],
            btickers[coin.binance_symbol],
            coin.id
          )

          book_ticker_list << new_bt
        end
      end

      book_ticker_list
    end
  end


  def self.book_ticker(coin)

    book_ticker_hash = ApiUtils.get_api_res("https://api.binance.us/api/v3/ticker/bookTicker?symbol=#{coin.binance_symbol}")
    price_hash = ApiUtils.get_api_res("https://api.binance.us/api/v3/ticker/price?symbol=#{coin.binance_symbol}")

    # If either of the API request fail, returns nil, otherwise returns a new BookTicker
    if book_ticker_hash.nil? or price_hash.nil?
      nil
    else
      book_ticker = create_book_ticker(price_hash, book_ticker_hash, coin.id)
      book_ticker
    end
  end

  def self.current_average_price(coin)

    avg_price_hash = ApiUtils.get_api_res("https://api.binance.us/api/v3/avgPrice?symbol=#{coin.binance_symbol}")

    # If the API request fails, returns nil, otherwise returns the average price of the coin
    if average_price_hash.nil?
      nil
    else
      avg_price_hash["price"]
    end
  end

end
        