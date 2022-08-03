class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.integer :owner_id
      t.integer :user_id
      t.string :group_name
      t.date :round_day
      t.string :round_place

      t.timestamps
    end
  end
end
