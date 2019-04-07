class AddLevelToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :level, :integer, default: 0
  end
end
