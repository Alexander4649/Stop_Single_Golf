class CreateGroupComments < ActiveRecord::Migration[6.1]
  def change
    create_table :group_comments do |t|
      t.integer :user_id, null: false
      t.integer :group_id, null: false
      t.text :comment

      t.timestamps
    end
  end
end
