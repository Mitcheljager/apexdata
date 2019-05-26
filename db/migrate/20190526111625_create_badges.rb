class CreateBadges < ActiveRecord::Migration[5.2]
  def change
    create_table :badges do |t|
      t.string :title
      t.string :description
      t.string :image

      t.timestamps
    end
  end
end
