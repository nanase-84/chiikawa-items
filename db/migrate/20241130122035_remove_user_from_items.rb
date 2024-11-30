class RemoveUserFromItems < ActiveRecord::Migration[7.1]
  def change
    remove_reference :items, :user, null: false, foreign_key: true
  end
end
