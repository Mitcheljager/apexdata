class ChangeMoreDataValueTypes < ActiveRecord::Migration[5.2]
  def change
    if ActiveRecord::Base.connection.instance_values["config"][:adapter] == "sqlite3"
      change_column :event_legend_data, :initial_value, :bigint
      change_column :event_legend_data, :current_value, :bigint
      change_column :event_signups, :total_value, :bigint
    else
      change_column :event_legend_data, :initial_value, "bigint USING CAST(data_value AS bigint)"
      change_column :event_legend_data, :current_value, "bigint USING CAST(data_value AS bigint)"
      change_column :event_signups, :total_value, "bigint USING CAST(data_value AS bigint)"
    end
  end
end
