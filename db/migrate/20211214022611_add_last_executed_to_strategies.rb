class AddLastExecutedToStrategies < ActiveRecord::Migration[6.1]
  def change
    add_column :strategies, :last_executed, :datetime
  end
end
