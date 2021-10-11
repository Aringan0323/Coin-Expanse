module CoinHelper

	# Creates and returns a new BookTicker for the Coin.
	def self.getTicker(coin)

		ticker_uri = URI("https://api.binance.us/api/v3/ticker/bookTicker?symbol=#{coin.symbol}USDT")
		ticker_res = Net::HTTP.get_response(ticker_uri)

		avg_price_uri = URI("https://api.binance.us/api/v3/avgPrice?symbol=#{coin.symbol}USDT")
		average_price_res = Net::HTTP.get_response(avg_price_uri)

		# If either of the API requests fail, returns nil and nothing is created.
		if ticker_res.is_a?(Net::HTTPSuccess) and average_price_res.is_a?(Net::HTTPSuccess)
			ticker_json = JSON(ticker_res.body)
			avg_price_json = JSON(average_price_res.body)

			ticker = BookTicker.create(
				avgPrice: avg_price_json["price"],
				bidPrice: ticker_json["bidPrice"],
				bidQty: ticker_json["bidQty"],
				askPrice: ticker_json["askPrice"],
				askQty: ticker_json["askQty"],
				timestamp: DateTime.now(),
				coin_id: coin.id
			)

			return ticker

		else

			nil

		end


	end



end