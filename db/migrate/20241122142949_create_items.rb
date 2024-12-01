class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.string :image_url
      t.string :storage
      t.string :status

      t.timestamps
    end
  end
end
