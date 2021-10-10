class CreatePortfolioCoinJoinTables < ActiveRecord::Migration[6.1]
  def change
    create_table :portfolio_coin_join_tables do |t|
      t.belongs_to :coin
      t.belongs_to :portfolio
      
      t.timestamps
    end
  end
end
