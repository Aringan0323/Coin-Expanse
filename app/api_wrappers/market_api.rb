require "net/http"
require "uri"
require "json"




module MarketApi

  # Hash that maps the symbol (base asset, not binance symbol) of each coin to the name of the coin
  json_file = File.read("./db/seed_data/symbol_to_name.json")
  @symbol_to_name = JSON.parse(json_file)

  # Accepts a GET request string and then returns a hash of the response from the Binance api, or nil if
  # the request failed
  def self.get_api_res(get_request)
    uri = URI(get_request)
    res = Net::HTTP.get_response(uri)

    if res.is_a?(Net::HTTPSuccess)
      JSON(res.body)
    else
      nil
    end
  end

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

  # Creates and returns a new DaySummary ActiveRecord from a day_summary hash and a coin id
  def self.create_day_summary(day_summary_hash, coin_id)

    day_summary = DaySummary.new(
      priceChange: day_summary_hash["priceChange"],
      priceChangePercent: day_summary_hash["priceChangePercent"],
      weightedAvgPrice: day_summary_hash["weightedAvgPrice"],
      prevClosePrice: day_summary_hash["prevClosePrice"],
      lastPrice: day_summary_hash["lastPrice"],
      lastQty: day_summary_hash["lastQty"],
      bidPrice: day_summary_hash["bidPrice"],
      askPrice: day_summary_hash["askPrice"],
      openPrice: day_summary_hash["openPrice"],
      highPrice: day_summary_hash["highPrice"],
      lowPrice: day_summary_hash["lowPrice"],
      volume: day_summary_hash["volume"],
      openTime: Time.at(day_summary_hash["openTime"]/1000),
      closeTime: Time.at(day_summary_hash["closeTime"]/1000),
      tradeCount: day_summary_hash["count"],
      coin_id: coin_id
    )

    day_summary
  end

  

  def self.get_all_coins

    info = get_api_res("https://api.binance.us/api/v3/exchangeInfo")

    coins = []

    if info.nil?
      nil
    else
      symbols_info = info["symbols"]
      symbols_info.each do |symbol_info|

        spot = symbol_info["isSpotTradingAllowed"]
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

  def self.book_ticker(symbol)

    bticker_uri = URI("https://api.binance.us/api/v3/ticker/bookTicker?symbol=#{symbol}USD")
    bticker_res = Net::HTTP.get_response(bticker_uri)

    # Returns json object if get request succeeds, otherwise returns nil
    if bticker_res.is_a?(Net::HTTPSuccess)
      JSON(bticker_res.body)
    else
      nil
    end
  end

  def self.current_average_price(coin)

    avg_price_hash = get_api_res("https://api.binance.us/api/v3/avgPrice?symbol=#{coin.binance_symbol}")

    # If either of the API requests fail, returns nil and nothing is created.
    if average_price_hash.nil?
      nil
    else
      avg_price_hash["price"]
    end
  end


  def self.day_summary(symbol)

    day_summary_uri = URI("https://api.binance.us/api/v3/ticker/24hr?symbol=#{symbol}USD")
		day_summary_res = Net::HTTP.get_response(day_summary_uri)

    if day_summary_res.is_a?(Net::HTTPSuccess)
      JSON(day_summary_res.body)
    else
      nil
    end
  end


  def self.day_summaries(coins)

    day_summaries_list = get_api_res("https://api.binance.us/api/v3/ticker/24hr")

    if day_summaries_list.nil?
      nil
    else
      day_summaries = label_hash_list(day_summaries_list)

      day_summary_ar_list = []

      coins.each do |coin|
        if day_summaries.key?(coin.binance_symbol)
          day_summary_ar_list << create_day_summary(day_summaries[coin.binance_symbol], coin.id)
        end
      end

      day_summary_ar_list

    end
  end


  def self.book_tickers(coins)

    avg_prices_list = get_api_res("https://api.binance.us/api/v3/ticker/price")
    btickers_list = get_api_res("https://api.binance.us/api/v3/ticker/bookTicker")

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


end
        