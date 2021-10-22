class CreateCoins < ActiveRecord::Migration[6.1]
  def change
    create_table :coins do |t|
      t.string :symbol
      t.string :binance_symbol
      t.string :name
    end
  end
end
