class AddRawToStrategies < ActiveRecord::Migration[6.1]
  def change
    add_column :strategies, :raw, :string
  end
end
