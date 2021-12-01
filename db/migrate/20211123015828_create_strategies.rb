class CreateStrategies < ActiveRecord::Migration[6.1]
  def change
    create_table :strategies do |t|
      t.belongs_to :user
      t.string :coin_name
      t.string :type 
      t.float :amount
      t.string :algorithm

      t.timestamps
    end
  end
end
