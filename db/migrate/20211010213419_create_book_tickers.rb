class CreateBookTickers < ActiveRecord::Migration[6.1]
  def change
    create_table :book_tickers do |t|
      t.belongs_to :coin
      t.float :avgPrice
      t.float :bidPrice
      t.float :bidQty
      t.float :askPrice
      t.float :askQty
      t.datetime :timestamp
    end
  end
end
