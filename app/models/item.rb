class Item < ApplicationRecord
  
  has_many :items_tags, dependent: :destroy
  has_many :tags, through: :items_tags

  mount_uploader :image_url, ImageUploader

  validates :name, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 65_535 }
  validates :storage, length: { maximum: 255 }
end
