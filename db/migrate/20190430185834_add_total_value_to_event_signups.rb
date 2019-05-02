class AddTotalValueToEventSignups < ActiveRecord::Migration[5.2]
  def change
    add_column :event_signups, :total_value, :string, default: 0
  end
end
