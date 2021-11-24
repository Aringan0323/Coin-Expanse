require 'json'
require 'uri'
require 'net/http'
require './app/api_wrappers/market_api.rb'

puts "Deleting all indicators"
Indicator.delete_all

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

puts "Creating coin indicators"
first = true
Coin.all.each do |coin|
  if !first
    sleep(16.seconds)
  else
    first = false
  end
  indics = []
  indics << Indicator.new(coin: coin, name: "#{coin.symbol}_rsi")
  indics << Indicator.new(coin: coin, name: "#{coin.symbol}_stoch")
  indics << Indicator.new(coin: coin, name: "#{coin.symbol}_macd")
  indics << Indicator.new(coin: coin, name: "#{coin.symbol}_bbands2")
  indics << Indicator.new(coin: coin, name: "#{coin.symbol}_vwap")
  IndicatorApi.bulk(coin, "1h", indics)
  indics.each do |indic|
    indic.save
  end
end
puts "Created indicators"

