class AddFlipperForLogin < ActiveRecord::Migration[5.2]
  def up
    Flipper.add(:login)
  end

  def down
    Flipper.remove(:login)
  end
end
