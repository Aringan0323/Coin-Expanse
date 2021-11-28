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

  def chart_avg_data
    render json: Coin.find(params[:id]).book_tickers.pluck(:timestamp, :avgPrice).to_json
  end

  def chart_ask_data

    render json: Coin.find(params[:id]).book_tickers.pluck(:timestamp, :askPrice).to_json
  end

  def chart_bid_data

    render json: Coin.find(params[:id]).book_tickers.pluck(:timestamp, :bidPrice).to_json
  end
end