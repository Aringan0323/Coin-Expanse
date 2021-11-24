class CreateStrategies < ActiveRecord::Migration[6.1]
  def change
    create_table :strategies do |t|
      t.string :algorithm

      t.timestamps
    end
  end
end
