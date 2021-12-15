class OrderController < PrivateController
  include UserHelper
  include SessionsHelper
  def index
    @coins = Coin.all
    @orders = current_user.orders
  end

  def order
    require_login
    # begin
    coin = Coin.find(params[:coin_id])
    qty = params[:quantity].to_f
    response = nil
    side_string = "sold"
    if params[:buy] == "true"
      side_string = "bought"
      response = OrderApi.buy(current_user, coin, qty)
    else
      response = OrderApi.sell(current_user, coin, qty)
    end
    puts("****____#{side_string}____****")
    if response.success?
      flash[:success] = "You successfully #{side_string} #{qty} #{qty == 1 ? 'coin' : 'coins'} of #{coin.name}"
      redirect_to '/order'
    else
      flash[:danger] = JSON.parse(response.body)['msg']
      redirect_to '/order'
    end
  end
end
