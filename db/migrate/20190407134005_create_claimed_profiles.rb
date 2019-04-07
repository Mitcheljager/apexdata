class CreateClaimedProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :claimed_profiles do |t|
      t.integer :user_id, limit: 12
      t.integer :profile_uid, limit: 12

      t.timestamps
    end
  end
end
