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
      if params[:buy]
        OrderApi.buy(current_user, coin, qty)
      else
        OrderApi.sell(current_user, coin, qty)
      end
      flash[:notice] =
        "You successfully #{params[:buy] ? 'bought' : 'sold'} #{qty} #{pluralize(qty, 'coin')} of #{coin.name}"
      redirect_to root_url
    rescue Binance::Api::Error::NewOrderRejected
      flash[:danger] = 'Insufficient funds to make this order'
      redirect_to '/order'
    rescue Binance::Api::Error::InvalidQuantity
      flash[:danger] = 'Please enter an quantity greater than 0'
      redirect_to '/order'
    rescue Binance::Api::Error::IllegalChars
      flash[:danger] = 'Please enter a valid quantity'
      redirect_to '/order'
    end
  end
end
