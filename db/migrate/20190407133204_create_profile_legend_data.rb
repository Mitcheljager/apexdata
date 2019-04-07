class CreateProfileLegendData < ActiveRecord::Migration[5.2]
  def change
    create_table :profile_legend_data do |t|
      t.integer :user_id
      t.string :legend
      t.string :data_name
      t.string :data_value

      t.timestamps
    end
  end
end
