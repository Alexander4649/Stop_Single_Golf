class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.integer :user_id, null: false, default: ""
      t.integer :owner_id, null: false, default: ""
      t.string :group_name, null: false
      t.string :image_id
      t.date :round_day
      t.string :round_place

      t.timestamps
    end
  end
end
