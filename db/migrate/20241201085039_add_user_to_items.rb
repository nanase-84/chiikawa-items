class AddUserToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :user_id, :integer
    add_reference :items, :user, null:, foreign_key: true, null: false
  end
end
