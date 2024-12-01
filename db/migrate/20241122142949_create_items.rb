class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.string :image_url
      t.string :storage
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
