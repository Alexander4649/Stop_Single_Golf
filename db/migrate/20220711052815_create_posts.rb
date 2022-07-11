class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false, default: ""
      t.string :title,    null: false, default: ""
      t.text :body,       null: false, default: ""
      t.integer :post_image_id, null: false, default: ""
      t.text :post_image_url, null: false, default: ""
      t.date :day
      t.float :score
      t.string :place

      t.timestamps
    end
  end
end
