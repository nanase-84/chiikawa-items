class AddFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string
    add_column :users, :profile_image, :string
    add_column :users, :birthday, :date
  end
end
