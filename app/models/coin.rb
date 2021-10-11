require 'date'

class Coin < ApplicationRecord
  has_many :day_summaries
  has_many :book_tickers
  
  has_many :portfolio_coin_join_tables
  has_many :portfolios, through: :portfolio_coin_join_tables

  # # Creates and returns a new BookTicker for the Coin.
  # def getTicker

  #   ticker_uri = URI("https://api.binance.us/api/v3/ticker/bookTicker?symbol=#{:symbol}USDT")
  #   ticker_res = Net::HTTP.get_response(ticker_uri)

  #   avg_price_uri = URI("https://api.binance.us/api/v3/avgPrice?symbol=#{:symbol}USDT")
  #   average_price_res = Net::HTTP.get_response(avg_price_uri)
  #   puts "before conditional"
  #   # If either of the API requests fail, returns nil and nothing is created.
  #   if ticker_res.is_a?(Net::HTTPSuccess) and avg_price_res.is_a?(Net::HTTPSuccess)
  #     puts "this was a success!"
  #     ticker_json = JSON(ticker_res.body)
  #     avg_price_json = JSON(average_price_res.body)

  #     ticker = BookTicker.create(
  #       avgPrice: avg_price_json["price"],
  #       bidPrice: ticker_json["bidPrice"],
  #       bidQty: ticker_json["bidQty"],
  #       askPrice: ticker_json["askPrice"],
  #       askQty: ticker_json["askQty"],
  #       timestamp: DateTime.now()
  #     )

  #     :book_tickers << ticker

  #     return ticker

  #   else

  #     nil

  #   end

  # end
  
end
