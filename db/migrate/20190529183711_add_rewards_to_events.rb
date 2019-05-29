class AddRewardsToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :badge_id_first_place, :integer
    add_column :events, :badge_id_participation, :integer
    add_column :events, :reward_first_place, :string
    add_column :events, :reward_second_place, :string
    add_column :events, :reward_third_place, :string
  end
end
