require './app/helpers/user_helper'
require 'faker'
require 'date'

puts("Deleting all users")
User.delete_all

User.create(username: "admin", email: "test@gmail.com", password: "pass")
puts "Admin user created"
