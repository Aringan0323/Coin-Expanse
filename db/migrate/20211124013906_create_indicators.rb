class CreateIndicators < ActiveRecord::Migration[6.1]
  def change
    create_table :indicators do |t|
      t.references :coin, null: false, foreign_key: true
      t.string :name
      t.string :data
      t.string :interval

      t.timestamps
    end
  end
end
