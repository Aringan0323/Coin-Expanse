require "./app/api_wrappers/order_api.rb"

module UserHelper 

  def self.digest_password(password)
    Digest::SHA384.hexdigest password
  end

  def self.check_orders
    puts OrderApi.check_orders
  end

  def self.buy(coin, qty)
    puts OrderApi.buy(coin, qty)
  end

  def self.sell(coin, qty)
    puts OrderApi.sell(coin, qty)
  end

  # For testing buying and selling
  def self.buy_test(coin, qty, user)
    puts OrderApi.buy_test(coin, qty, user)
  end

  def self.sell_test(coin, qty, user)
    puts OrderApi.sell_test(coin, qty, user)
  end

end  