require "net/http"
require "uri"
require "json"


module MarketApi

  
  def self.ticker_price(symbol)
    ticker_uri = URI("https://api.binance.us/api/v3/ticker/price?symbol=#{symbol}USDT")
    ticker_res = Net::HTTP.get_response(ticker_uri)

    # Returns json object if get request succeeds, otherwise returns nil
    if ticker_res.is_a?(Net::HTTPSuccess)
      JSON(ticker_res.body)
    else
      nil
    end
  end

  def self.book_ticker(symbol)

    ticker_uri = URI("https://api.binance.us/api/v3/ticker/bookTicker?symbol=#{symbol}USDT")
    ticker_res = Net::HTTP.get_response(ticker_uri)

    # Returns json object if get request succeeds, otherwise returns nil
    if ticker_res.is_a?(Net::HTTPSuccess)
      JSON(ticker_res.body)
    else
      nil
    end
  end

  def self.current_average_price(symbol)

    avg_price_uri = URI("https://api.binance.us/api/v3/avgPrice?symbol=#{coin.symbol}USDT")
    average_price_res = Net::HTTP.get_response(avg_price_uri)

    # If either of the API requests fail, returns nil and nothing is created.
    if average_price_res.is_a?(Net::HTTPSuccess)
      JSON(average_price_res.body)
    else
      nil
    end
  end

end
        