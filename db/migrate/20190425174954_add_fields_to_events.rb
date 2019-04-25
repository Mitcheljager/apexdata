class AddFieldsToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :title, :string
    add_column :events, :description, :text 
    add_column :events, :data_names, :string
    add_column :events, :legends, :string
    add_column :events, :start_datetime, :datetime
    add_column :events, :end_datetime, :datetime
  end
end
