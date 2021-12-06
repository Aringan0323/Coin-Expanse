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

ENV["TAAPI_API_KEY"] = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFkYW1yaW5nQGJyYW5kZWlzLmVkdSIsImlhdCI6MTYzNTUzOTAyNCwiZXhwIjo3OTQyNzM5MDI0fQ.yJTKVpk9ki71pIzHua0OLb9JdHIAyXbQzcHzWBulAoE"

puts "Creating coin indicators"
first = true
indic_names = ["rsi", "stoch", "macd", "bbands2", "vwap"]
waiting_time = 60
Coin.all.each do |coin|
  ["1h", "1d", "1w"].each do |interval|
    if !first
      sleep(16.seconds)
    else
      first = false
    end
    indics = []
    indic_names.each do |indic_name|
      indics << Indicator.new(coin: coin, name: "#{coin.symbol}_#{indic_name}", interval: interval)
    end
    IndicatorApi.bulk(coin, interval, indics)
    indics.each do |indic|
      indic.save
    end
    puts "Created #{coin.name} #{interval} indicators"
  end
end
puts "Created all indicators"

