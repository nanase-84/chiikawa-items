class ItemsTag < ApplicationRecord
  belongs_to :item
  belongs_to :tag

  validates :item_id, uniqueness: { scope: :tag_id }
end
