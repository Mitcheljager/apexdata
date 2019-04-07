class CreateClaimedProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :claimed_profiles do |t|
      t.integer :user_id
      t.integer :profile_uid

      t.timestamps
    end
  end
end
