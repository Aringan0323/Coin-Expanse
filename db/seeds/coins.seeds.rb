require 'json'
require 'uri'
require 'net/http'
require './app/helpers/coin_helper.rb'
require './app/helpers/market_api.rb'

puts("Deleting all coins")
Coin.delete_all
puts("Deleting all day summaries")
DaySummary.delete_all
puts("Deleting all book tickers")
BookTicker.delete_all

symbols = MarketApi.get_all_symbols

json_file = File.read("./db/seed_data/symbol_to_name.json")
symbol_to_name = JSON.parse(json_file)


symbols.each do |symbol|
  coin = Coin.create(symbol: symbol, name: symbol_to_name[symbol])
  CoinHelper.getTicker(coin)
  CoinHelper.getDaySummary(coin)
  puts("Created #{symbol} coin")
end
puts("Created ALL coins")

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
