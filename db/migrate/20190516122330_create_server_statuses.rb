class CreateServerStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :server_statuses do |t|
      t.string :display
      t.string :group
      t.string :host
      t.decimal :response_time

      t.timestamps
    end
  end
end
