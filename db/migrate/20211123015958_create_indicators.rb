class CreateIndicators < ActiveRecord::Migration[6.1]
  def change
    create_table :indicators do |t|
      t.string :name
      t.string :data

      t.timestamps
    end
  end
end
