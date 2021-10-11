class CoinController < ApplicationController

  def index
    @coins = Coin.all
  end



end