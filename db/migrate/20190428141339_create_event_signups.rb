class CreateEventSignups < ActiveRecord::Migration[5.2]
  def change
    create_table :event_signups do |t|
      t.integer :event_id
      t.integer :user_id
      t.string :profile_uid

      t.timestamps
    end
  end
end
