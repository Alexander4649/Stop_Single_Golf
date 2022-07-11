class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.integer :user_id, null: false, default: ""
      t.string :group_name, null: false, default: ""
      t.text :group_image_url, null: false, default: ""
      t.date :round_day
      t.string :round_place

      t.timestamps
    end
  end
end
