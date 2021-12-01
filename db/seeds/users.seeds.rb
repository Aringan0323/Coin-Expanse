require './app/helpers/user_helper'
require 'faker'
require 'date'

puts("Deleting all users")
User.delete_all

User.create(
    full_name: "Psuedo User",
    username: "admin",
    email: "test@gmail.com",
    password: "pass",
    binance_public_key: "FVDgHdYvlx2QTaXO5yZtIwtIVLcZ0xIEPho9dxVHbFMNyI8DELpm3IotYPdOQ1e4",
    encryptedBinanceApiKey: "zZH85w6d8M3gnXSWoMZa0xMCTKuE4ov7DcDHx3POS8U3nkYJELCL6B8TIkS1pqNR"
)
puts "Admin user created"
