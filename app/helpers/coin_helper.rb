require "./app/api_wrappers/market_api.rb"

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


	def self.getDaySummary(coin)

		json = MarketApi.day_summary(coin.symbol)		

		if json.nil?

			puts "Day summary data for #{coin.symbol} could not be fetched"

		else
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
			
		end
	end



	def render_avg_price_chart(coin)
		btickers = coin.book_tickers.order(:timestamp)
		data = btickers.map { |bt| [bt.timestamp, bt.avgPrice] }.to_h
		min = btickers.minimum(:avgPrice)
		# max = btickers.maximum(:avgPrice)
		line_chart data,
			min: min,
			ytitle: "USD",
			title: "#{coin.symbol}: $#{btickers.last.avgPrice}",
			height: "500px",
			curve: false,
			points: false,
			round: 2,
			zeros: true,
			prefix: "$",
			thousands: ","

	end

	def render_avg_price_chart(coin)
		btickers = coin.book_tickers.order(:timestamp)
		data = btickers.map { |bt| [bt.timestamp, bt.avgPrice] }.to_h
		min = btickers.minimum(:avgPrice)
		line_chart data,
			min: min,
			ytitle: "USD",
			title: "#{coin.name} Average Price: $#{btickers.last.avgPrice}",
			height: "500px",
			curve: false,
			points: false,
			round: 2,
			zeros: true,
			prefix: "$",
			thousands: ","

	end



	def render_ask_price_chart(coin)
		btickers = coin.book_tickers.order(:timestamp)
		data = btickers.map { |bt| [bt.timestamp, bt.askPrice] }.to_h
		min = btickers.minimum(:askPrice)
		line_chart data,
			min: min,
			ytitle: "USD",
			title: "#{coin.name} Ask Price: $#{btickers.last.askPrice}",
			height: "500px",
			curve: false,
			points: false,
			round: 2,
			zeros: true,
			prefix: "$",
			thousands: ","

	end


	def render_bid_price_chart(coin)
		btickers = coin.book_tickers.order(:timestamp)
		data = btickers.map { |bt| [bt.timestamp, bt.bidPrice] }.to_h
		min = btickers.minimum(:bidPrice)
		line_chart data,
			min: min,
			ytitle: "USD",
			title: "#{coin.name} Bid Price: $#{btickers.last.bidPrice}",
			height: "500px",
			curve: false,
			points: false,
			round: 2,
			zeros: true,
			prefix: "$",
			thousands: ","

	end


#   def self.getDaySummaries(coin_list)

# 		day_summaries = MarketApi.day_summaries	

# 		if day_summaries.nil?

# 			puts "Day summary data for all coins could not be fetched"

# 		else

#       		day_summary_dict = {}
# 		end
#       day_summaries.each do |s|
#         symbol = s["symbol"][0..-3]
#         if coin_name_list.include? symbol



# 			day_summary = DaySummary.create(
# 				priceChange: json["priceChange"],
# 				priceChangePercent: json["priceChangePercent"],
# 				weightedAvgPrice: json["weightedAvgPrice"],
# 				prevClosePrice: json["prevClosePrice"],
# 				lastPrice: json["lastPrice"],
# 				lastQty: json["lastQty"],
# 				bidPrice: json["bidPrice"],
# 				askPrice: json["askPrice"],
# 				openPrice: json["openPrice"],
# 				highPrice: json["highPrice"],
# 				lowPrice: json["lowPrice"],
# 				volume: json["volume"],
# 				openTime: Time.at(json["openTime"]/1000),
# 				closeTime: Time.at(json["closeTime"]/1000),
# 				tradeCount: json["count"],
# 				coin_id: coin.id
# 			)
			
# 		end
# 	end




end