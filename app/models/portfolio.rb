class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :portfolio_coin_join_tables
  has_many :coins, through: :portfolio_coin_join_tables
end
