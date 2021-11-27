class AddBinancePublicKeyToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :binance_public_key, :string
  end
end
