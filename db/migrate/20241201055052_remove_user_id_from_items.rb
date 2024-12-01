class RemoveUserIdFromItems < ActiveRecord::Migration[7.1]
  def change
    remove_column :items, :user_id, :bigint
  end
end
