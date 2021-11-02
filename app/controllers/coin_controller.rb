class CoinController < PrivateController

  def index
    puts "params: #{params[:search_param]}"
    if params[:search_param].eql? nil
      @coins = Coin.all
    else 
      puts "HERE"
      @coins = Coin.where("symbol like ?", "%#{params[:search_param]}%")
    end
  end

  def show
    puts "params: #{params[:search_param]}"
    puts "id: #{params[:id]}"
    @coin = Coin.find(params[:id])
  end
end