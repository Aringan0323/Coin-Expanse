require 'date'

class Coin < ApplicationRecord
  has_many :book_tickers
  has_many :indicators
  
end
