class AddFlipperForProfiles < ActiveRecord::Migration[5.2]
  def up
    Flipper.add(:profiles)
  end

  def down
    Flipper.remove(:profiles)
  end
end
