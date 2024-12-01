class AddUserToItems < ActiveRecord::Migration[7.1]
  def change
    add_reference :items, null: false, :user, null:, foreign_key: true
  end
end
