class ChangeMoreDataValueTypes < ActiveRecord::Migration[5.2]
  def change
    if ActiveRecord::Base.connection.instance_values["config"][:adapter] == "sqlite3"
      change_column :event_legend_data, :initial_value, :bigint
      change_column :event_legend_data, :current_value, :bigint
      change_column :event_signups, :total_value, :bigint
    else
      change_column :event_legend_data, :initial_value, "bigint USING CAST(initial_value AS bigint)"
      change_column :event_legend_data, :current_value, "bigint USING CAST(current_value AS bigint)"
      change_column_default :event_signups, :total_value, nil
      change_column :event_signups, :total_value, "bigint USING CAST(total_value AS bigint)"
      change_column_default :event_signups, :total_value, 0
    end
  end
end
