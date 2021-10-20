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
  puts("Created #{coin.name}")
end

puts("Creating day summaries")
day_summaries = MarketApi.day_summaries(Coin.all)

day_summaries.each do |day_summary|
  day_summary.save
end

puts("Creating book tickers")
book_tickers = MarketApi.book_tickers(Coin.all)
puts(book_tickers)
book_tickers.each do |book_ticker|
  book_ticker.save
end

# json_file = File.read("./db/seed_data/symbol_to_name.json")
# symbol_to_name = JSON.parse(json_file)


# symbols.each do |symbol|
#   coin = Coin.create(symbol: symbol, name: symbol_to_name[symbol])
#   CoinHelper.getTicker(coin)
#   CoinHelper.getDaySummary(coin)
#   puts("Created #{symbol} coin")
# end
# puts("Created ALL coins")

# def createCoinsFromSymbols

#   info_uri = URI("https://api.binance.us/api/v3/exchangeInfo")
#   info_res = Net::HTTP.get_response(info_uri)

# 	if info_res.is_a?(Net::HTTPSuccess)
# 		symbols_info = JSON(info_res.body)["symbols"]

#     symbols_info.each do |symbol_info|

#       spot = symbol_info["isSpotTradingAllowed"]

#       has_usd_conversion = symbol_info["quoteAsset"] == "USD"

#       next if spot && has_usd_conversion

#       symbol = symbol_info["baseAsset"]

#       coin = Coin.create(symbol: symbol, name: @symbol_to_name[symbol])
#       CoinHelper.getTicker(coin)
#       CoinHelper.getDaySummary(coin)
      

#     end
# 	else
# 		nil
# 	end
# end

# createCoinsFromSymbols
