class AddVisibilityToDistributedBadges < ActiveRecord::Migration[5.2]
  def change
    add_column :distributed_badges, :visibility, :integer, default: 1
  end
end
