class CreateDaySummaries < ActiveRecord::Migration[6.1]
  def change
    create_table :day_summaries do |t|
      t.belongs_to :coin
      t.float :priceChange
      t.float :priceChangePercent
      t.float :weightedAvgPrice
      t.float :prevClosePrice
      t.float :lastPrice
      t.float :lastQty
      t.float :bidPrice
      t.float :askPrice
      t.float :openPrice
      t.float :highPrice
      t.float :lowPrice
      t.float :volume
      t.datetime :openTime
      t.datetime :closeTime
      t.integer :tradeCount
    end
  end
end
