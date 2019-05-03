class ChangeDataValuesOfEventToFloat < ActiveRecord::Migration[5.2]
  def change
    change_column :event_legend_data, :initial_value, :integer
    change_column :event_legend_data, :current_value, :integer
    change_column :event_signups, :total_value, :integer
  end
end
