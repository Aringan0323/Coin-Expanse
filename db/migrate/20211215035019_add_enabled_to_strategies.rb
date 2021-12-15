class AddEnabledToStrategies < ActiveRecord::Migration[6.1]
  def change
    add_column :strategies, :enabled, :boolean, :default => false
  end
end
