class CreateDistributedBadges < ActiveRecord::Migration[5.2]
  def change
    create_table :distributed_badges do |t|
      t.string :profile_uid
      t.integer :badge_id

      t.timestamps
    end
  end
end
