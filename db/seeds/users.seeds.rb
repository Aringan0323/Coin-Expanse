require './app/helpers/user_helper'
require 'faker'
require 'date'

puts("Deleting all users")
User.delete_all

User.create(username: "admin", email: "test@gmail.com", password: "pass", binance_public_key: "zsXP0MQ3XUQ3clwfewN45dLm0xcBlks0QokSUsLaxT9PkvXMiarAhXYTxy7sHRMi", encryptedBinanceApiKey: "f2xDJ4YJSLUrddqvpk5nQg62XfD8gcPMsikOpkPPhRxB5iKYTf2LXf2tnOLcx8cn")
puts "Admin user created"
