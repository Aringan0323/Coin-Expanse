require "net/http"
require "uri"
require "json"


module MarketApi


  def self.get_all_symbols

    info_uri = URI("https://api.binance.us/api/v3/exchangeInfo")
    info_res = Net::HTTP.get_response(info_uri)

    compatible_symbols = []

    if info_res.is_a?(Net::HTTPSuccess)
      symbols_info = JSON(info_res.body)["symbols"]

      symbols_info.each do |symbol_info|

        spot = symbol_info["isSpotTradingAllowed"]

        has_usd_conversion = symbol_info["quoteAsset"] == "USD"
        
        if spot && has_usd_conversion

          compatible_symbols << symbol_info["baseAsset"]
        end
      end
    end

    compatible_symbols
  end


  
  def self.ticker_price(symbol)
    ticker_uri = URI("https://api.binance.us/api/v3/ticker/price?symbol=#{symbol}USD")
    ticker_res = Net::HTTP.get_response(ticker_uri)

    # Returns json object if get request succeeds, otherwise returns nil
    if ticker_res.is_a?(Net::HTTPSuccess)
      JSON(ticker_res.body)
    else
      nil
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

  def self.current_average_price(symbol)

    avg_price_uri = URI("https://api.binance.us/api/v3/avgPrice?symbol=#{symbol}USD")
    average_price_res = Net::HTTP.get_response(avg_price_uri)

    # If either of the API requests fail, returns nil and nothing is created.
    if average_price_res.is_a?(Net::HTTPSuccess)
      JSON(average_price_res.body)
    else
      nil
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

end
        