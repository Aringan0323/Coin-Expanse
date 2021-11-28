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

	def broadcast_coin(coin)

    # avg_chart = render_chart(coin, "average", "avgPrice")
    # ask_chart = render_chart(coin, "ask", "askPrice")
    # bid_chart = render_chart(coin, "bid", "bidPrice")

    ActionCable.server.broadcast(
      "#{coin.symbol}",
      {
        btickers: coin.book_tickers
      }
    )
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
	def render_chart(data)


		line_chart data["chart_data"],
			min: data["min_price"],
			ytitle: "USD",
			title: "#{data["coin_name"]} #{data["display_type"]} price: $#{data["latest_price"]}",
			height: "500px",
			curve: false,
			points: false,
			round: 2,
			zeros: true,
			prefix: "$",
			thousands: ","

	end
end