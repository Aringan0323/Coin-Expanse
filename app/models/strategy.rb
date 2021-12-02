class Strategy < ApplicationRecord
    belongs_to :user
    validates :side, inclusion: { in: %w(BUY SELL),
        message: "%{value} is not a valid amount" }
    validates :amount, numericality: {greater_than_or_equal_to: 0.0,
        message: "Cannot have a negative amount"}
end
