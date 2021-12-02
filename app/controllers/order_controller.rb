class OrderController < PrivateController
  include UserHelper
  include SessionsHelper
  def index
    @coins = Coin.all
  end

  def order
    require_login
    begin
      coin = Coin.find(params[:coin_id])
      qty = params[:quantity].to_f
      if params[:buy] == "true"
        OrderApi.buy(current_user, coin, qty)
      else
        OrderApi.sell(current_user, coin, qty)
      end
      flash[:success] =
        "You successfully #{params[:buy] ? 'bought' : 'sold'} #{qty} #{qty == 1 ? 'coin' : 'coins'} of #{coin.name}"
      redirect_to root_url
    rescue Binance::Api::Error::NewOrderRejected
      flash[:danger] = 'Your order was rejected'
      redirect_to '/order'
    rescue Binance::Api::Error::InvalidQuantity
      flash[:danger] = 'Please enter a valid qantity.'
      redirect_to '/order'
    rescue Binance::Api::Error::IllegalChars
      flash[:danger] = 'Please enter a valid quantity'
      redirect_to '/order'
    end
  end
end
