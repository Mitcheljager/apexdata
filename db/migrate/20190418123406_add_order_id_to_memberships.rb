class AddOrderIdToMemberships < ActiveRecord::Migration[5.2]
  def change
    add_column :memberships, :order_id, :string
  end
end
