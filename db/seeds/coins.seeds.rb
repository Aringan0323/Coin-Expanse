require 'json'
require 'uri'
require 'net/http'
# require './app/helpers/coin_helper.rb'
require './app/api_wrappers/market_api.rb'

puts("Deleting all coins")
Coin.delete_all

puts("Deleting all day summaries")
DaySummary.delete_all

puts("Deleting all book tickers")
BookTicker.delete_all

puts("Creating coins")
coins = MarketApi.get_all_coins

coins.each do |coin|
  coin.save
end

puts("Creating day summaries")
day_summaries = MarketApi.day_summaries(Coin.all)

day_summaries.each do |day_summary|
  day_summary.save
end

puts("Creating book tickers")
book_tickers = MarketApi.book_tickers(Coin.all)

book_tickers.each do |book_ticker|
  book_ticker.save
end

