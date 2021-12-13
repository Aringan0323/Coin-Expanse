require "./app/api_wrappers/market_api.rb"
require "chartkick"
module CoinHelper


	# Creates and returns a new BookTicker for the Coin.
	def self.getTicker(coin)

		ticker_json = MarketApi.book_ticker(coin.symbol)
		ticker_uri = URI("https://api.binance.us/api/v3/ticker/bookTicker?symbol=#{coin.symbol}USD")
		ticker_res = Net::HTTP.get_response(ticker_uri)

		avg_price_uri = URI("https://api.binance.us/api/v3/avgPrice?symbol=#{coin.symbol}USD")
		average_price_res = Net::HTTP.get_response(avg_price_uri)

		avg_price_json = MarketApi.current_average_price(coin.symbol)

		if ticker_json.nil? or avg_price_json.nil?

			puts "Ticker data for #{coin.symbol} could not be fetched"

		else

			BookTicker.create(
				avgPrice: avg_price_json["price"],
				bidPrice: ticker_json["bidPrice"],
				bidQty: ticker_json["bidQty"],
				askPrice: ticker_json["askPrice"],
				askQty: ticker_json["askQty"],
				timestamp: DateTime.now(),
				coin_id: coin.id
			)

		end


	end
	
	
	def get_chart_data(coin, display_type, type)
		data = {}
		book_tickers = coin.book_tickers.order(:timestamp)
		prices = book_tickers.pluck(type)
		data["chart_data"] = book_tickers.pluck(:timestamp, type)
		data["latest_price"] = prices.last
		data["min_price"] = prices.min
		data["display_type"] = display_type
		data["coin_name"] = coin.name

		data

	end


	def get_ind_data(coin)
		all_inds = coin.indicators
		hour_inds = coin.indicators.where(interval: "1h").map {|ind| [ind.name, JSON.parse(ind.data.gsub("=>", ":"))]}.to_h
		day_inds = coin.indicators.where(interval: "1d").map {|ind| [ind.name, JSON.parse(ind.data.gsub("=>", ":"))]}.to_h
		week_inds = coin.indicators.where(interval: "1w").map {|ind| [ind.name, JSON.parse(ind.data.gsub("=>", ":"))]}.to_h
		inds_hash = {"1h"=>hour_inds, "1d"=>day_inds, "1w"=>week_inds}
		pp inds_hash
		inds_hash
        
	end
end