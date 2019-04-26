class ChangeLimitOfProfileUidInClaimedProfiles < ActiveRecord::Migration[5.2]
  def change
    change_column :claimed_profiles, :profile_uid, :string, :limit => 255
  end
end
