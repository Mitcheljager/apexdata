class CreateRewards < ActiveRecord::Migration[5.2]
  def change
    create_table :rewards do |t|
      t.integer :user_id
      t.string :title
      t.string :description
      t.string :content

      t.timestamps
    end
  end
end
