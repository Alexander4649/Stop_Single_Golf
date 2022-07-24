class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false, default: ""
      t.string :title,    null: false, default: ""
      t.text :body,       null: false, default: ""
      t.integer :post_image_id, null: false, default: ""
      t.text :post_image_url, null: false, default: ""
      t.date :round_day,       null: false, default: ""
      t.float :in_score,       null: false, default: ""
      t.float :out_score,       null: false, default: ""
      t.string :round_place,       null: false, default: ""

      t.timestamps
    end
  end
end
