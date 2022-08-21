class AddColumnTokenToContact < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :token, :string
  end
end
