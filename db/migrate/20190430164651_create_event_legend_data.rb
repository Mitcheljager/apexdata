class CreateEventLegendData < ActiveRecord::Migration[5.2]
  def change
    create_table :event_legend_data do |t|
      t.integer :event_id
      t.string :profile_uid
      t.string :legend
      t.string :initial_value
      t.string :current_value

      t.timestamps
    end
  end
end
