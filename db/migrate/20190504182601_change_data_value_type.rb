class ChangeDataValueType < ActiveRecord::Migration[5.2]
  def change
    if ActiveRecord::Base.connection.instance_values["config"][:adapter] == "sqlite3"
      change_column :profile_legend_data, :data_value, :bigint
    else
      change_column :profile_legend_data, :data_value, "bigint USING CAST(data_value AS bigint)"
    end
  end
end
