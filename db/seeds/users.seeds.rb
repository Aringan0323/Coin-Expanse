require './app/helpers/user_helper'
require 'faker'
require 'date'

puts("Deleting all users")
Order.delete_all

User.delete_all

admin = User.create(
    full_name: "Psuedo User",
    username: "admin",
    email: "test@gmail.com",
    password: ENV["ADMIN_PASSWORD"],
    binance_public_key: ENV["ADMIN_PUBLIC_KEY"],
    encryptedBinanceApiKey: ENV["ADMIN_SECRET_KEY"]
)

coin_symbols = Coin.all.pluck(:symbol)
num_coins = coin_symbols.count
sides = ["BUY", "SELL"]

(0..40).each do |i|
    admin.orders << Order.create(
        amount: rand(0.200...3.000), 
        side: sides.sample, 
        symbol: coin_symbols.sample
    )
end

puts "Admin user created"

