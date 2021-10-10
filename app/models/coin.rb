class Coin < ApplicationRecord
  has_many :day_summaries
  has_many :order_tickers
  
  has_many :portfolio_coin_join_tables
  has_many :portfolios, through: :portfolio_coin_join_tables
end
