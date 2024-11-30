class Tag < ApplicationRecord
  has_many :items_tags, dependent: :destroy
  has_many :items, through: :items_tags

  validates :name, presence: true, uniqueness: true
end
