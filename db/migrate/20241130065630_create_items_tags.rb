class CreateItemsTags < ActiveRecord::Migration[7.1]
  def change
    create_table :items_tags do |t|
      t.references :item, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end

    add_index :items_tags, [:item_id, :tag_id], unique: true
  end
end
