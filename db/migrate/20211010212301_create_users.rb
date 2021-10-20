class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :passwordDigest
      t.string :encryptedBinanceApiKey
      t.datetime :userSince

      t.timestamps
    end
  end
end