class Item < ApplicationRecord

  
  validates :name, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 65_535 }
  validates :storage, length: { maximum: 255 }
end
