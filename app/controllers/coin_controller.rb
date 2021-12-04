class CoinController < PrivateController

  def index
    puts "params: #{params[:search_param]}"
    if params[:search_param].eql? nil
      @coins = Coin.all
    else 
      symbol = Coin.where("symbol ilike ?", "%#{params[:search_param]}%").to_a
      puts symbol
      name = Coin.where("name ilike ?", "%#{params[:search_param]}%").to_a
      puts name
      @coins = symbol | name
    end
  end

  def show
    puts "params: #{params[:search_param]}"
    puts "id: #{params[:id]}"
    @coin = Coin.find(params[:id]) 
  end

  # API endpoints for graphing data (average prices, ask prices, bid prices) over time 

  def chart_price_data
    data = []
    data << {name: "Average", data: Coin.find(params[:id]).book_tickers.pluck(:timestamp, :avgPrice)}
    data << {name: "Ask", data: Coin.find(params[:id]).book_tickers.pluck(:timestamp, :askPrice)}
    data << {name: "Bid", data: Coin.find(params[:id]).book_tickers.pluck(:timestamp, :bidPrice)}
    render json: data.to_json
  end

  def indicator_data
    indicator = Indicator.find(params[:indicator])
    data = []
    ind_data = JSON.parse(indicator.data.gsub("=>", ":"))
    ind_data.keys.each do |key|
      data << {name: key, data: ind_data[key].to_f}
    end
    data
  end
end