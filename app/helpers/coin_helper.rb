require "./app/helpers/market_api.rb"

module CoinHelper

	# Creates and returns a new BookTicker for the Coin.
	def self.getTicker(coin)

		ticker_json = MarketApi.book_ticker(coin.symbol)

		avg_price_json = MarketApi.current_average_price(coin.symbol)

		if ticker_json.nil? or average_price_json.nil?
			puts "Ticker data for #{coin.symbol} could not be fetched"
			nil
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


	def self.getDaySummary(coin)

		day_summary_uri = URI("https://api.binance.us/api/v3/ticker/24hr?symbol=#{coin.symbol}USDT")
		day_summary_res = Net::HTTP.get_response(day_summary_uri)

		# If either of the API requests fail, returns nil and nothing is created.
		if day_summary_res.is_a?(Net::HTTPSuccess)

			json = JSON(day_summary_res.body)

			day_summary = DaySummary.create(
			priceChange: json["priceChange"],
			priceChangePercent: json["priceChangePercent"],
			weightedAvgPrice: json["weightedAvgPrice"],
			prevClosePrice: json["prevClosePrice"],
			lastPrice: json["lastPrice"],
			lastQty: json["lastQty"],
			bidPrice: json["bidPrice"],
			askPrice: json["askPrice"],
			openPrice: json["openPrice"],
			highPrice: json["highPrice"],
			lowPrice: json["lowPrice"],
			volume: json["volume"],
			openTime: nil,
			closeTime: nil,
			tradeCount: json["count"],
			coin_id: coin.id
			)
			  
			return day_summary
		else
			puts "Day summary data for #{coin.symbol} could not be fetched"
			return nil
		end
	end

end