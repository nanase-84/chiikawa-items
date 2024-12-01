class Item < ApplicationRecord
  attr_accessor :tag_list

  has_many :items_tags, dependent: :destroy
  has_many :tags, through: :items_tags

  mount_uploader :image_url, ImageUploader

  validates :name, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 65_535 }
  validates :storage, length: { maximum: 255 }

  def assign_tags(tag_list)
    tag_names = tag_list.split(',').map(&:strip).uniq
    existing_tags = Tag.where(name: tag_names)
    new_tags = tag_names - existing_tags.pluck(:name)

    # Create new tags if they don't exist
    new_tags = new_tags.map { |name| Tag.create(name: name) }

    # Assign tags to the item
    self.tags = existing_tags + new_tags
  end
end
