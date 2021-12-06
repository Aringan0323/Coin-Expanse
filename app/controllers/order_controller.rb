class OrderController < PrivateController
  include UserHelper
  include SessionsHelper
  def index
    @coins = Coin.all
  end

  def order
    require_login
    # begin
    coin = Coin.find(params[:coin_id])
    qty = params[:quantity].to_f
    response = nil
    if params[:buy] == "true"
      response = OrderApi.buy(current_user, coin, qty)
    else
      response = OrderApi.sell(current_user, coin, qty)
    end
    if response.success?
      flash[:danger] = "You successfully #{params[:buy] ? 'bought' : 'sold'} #{qty} #{qty == 1 ? 'coin' : 'coins'} of #{coin.name}"
      redirect_to '/order'
    else
      flash[:danger] = JSON.parse(response.body)['msg']
      redirect_to '/order'
    end
  end
end
