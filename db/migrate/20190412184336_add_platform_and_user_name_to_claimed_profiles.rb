class AddPlatformAndUserNameToClaimedProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :claimed_profiles, :platform, :string
    add_column :claimed_profiles, :username, :string
  end
end
