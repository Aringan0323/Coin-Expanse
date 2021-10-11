class CreatePortfolios < ActiveRecord::Migration[6.1]
  def change
    create_table :portfolios do |t|
      t.belongs_to :user
      t.float :initialValue
      t.datetime :creationTimestamp
    end
  end
end
