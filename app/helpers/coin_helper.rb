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

	def broadcast_price_charts(coin)
		btickers = coin.book_tickers.order(:timestamp)
		avg_data = btickers.map { |bt| [bt.timestamp, bt.avgPrice] }.to_h
    latest_avg_price = btickers.last.avgPrice
		min_avg_price = btickers.minimum(:avgPrice)

    ask_data = btickers.map { |bt| [bt.timestamp, bt.askPrice] }.to_h
    latest_ask_price = btickers.last.askPrice
		min_ask_price = btickers.minimum(:askPrice)

    bid_data = btickers.map { |bt| [bt.timestamp, bt.bidPrice] }.to_h
    latest_bid_price = btickers.last.bidPrice
		min_bid_price = btickers.minimum(:bidPrice)

    avg_chart = render_chart(coin, avg_data, latest_avg_price, min_avg_price, "avg")
    ask_chart = render_chart(coin, ask_data, latest_ask_price, min_ask_price, "ask")
    bid_chart = render_chart(coin, biddata, latest_bid_price, min_bid_price, "bid")

    ActionCable.server.broadcast(
      "#{coin.symbol}_chart",
      {
        avg: avg_chart,
        ask: ask_chart,
        bid: bid_chart
      }
    )
	end


	def render_chart(coin, display_type, type)


		book_tickers = coin.book_tickers.order(:timestamp)
		data = book_tickers.pluck(:timestamp, type)
		prices = book_tickers.pluck(type)
		latest_price = prices.last
		min_price = prices.min
		type = "average"

		line_chart data,
			min: min_price,
			ytitle: "USD",
			title: "#{coin.name} #{display_type} price: $#{latest_price}",
			height: "500px",
			curve: false,
			points: false,
			round: 2,
			zeros: true,
			prefix: "$",
			thousands: ","

	end




end