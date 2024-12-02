class Item < ApplicationRecord
  attr_accessor :tag_list
  belongs_to :user

  has_many :items_tags, dependent: :destroy
  has_many :tags, through: :items_tags
  has_many :comments, dependent: :destroy

  mount_uploader :image_url, ImageUploader

  validates :name, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 65_535 }
  validates :storage, length: { maximum: 255 }

  def assign_tags
    return unless tag_list.present?

    self.tags = tag_list.split(',').map do |tag_name|
      Tag.find_or_create_by(name: tag_name.strip)
    end
  end
end
