class ChangeDataValuesOfEventToFloat < ActiveRecord::Migration[5.2]
  def change
    change_column :event_legend_data, :initial_value, :bigint
    change_column :event_legend_data, :current_value, :bigint
    change_column :event_signups, :total_value, :bigint
  end
end
