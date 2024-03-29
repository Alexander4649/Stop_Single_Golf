class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.string :title,    null: false
      t.text :body,       null: false
      t.date :round_day
      t.string :round_place
      t.json :images
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
