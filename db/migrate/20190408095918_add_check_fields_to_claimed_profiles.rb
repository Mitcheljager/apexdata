class AddCheckFieldsToClaimedProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :claimed_profiles, :check_1, :string
    add_column :claimed_profiles, :check_2, :string
    add_column :claimed_profiles, :check_3, :string
    add_column :claimed_profiles, :checks_completed, :integer, default: 0
  end
end
