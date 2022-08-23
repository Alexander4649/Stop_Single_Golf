class CreateRemoveReserveUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :remove_reserve_users do |t|
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
