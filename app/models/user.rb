class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :comments, dependent: :destroy
  has_many :items, dependent: :destroy

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, length: { maximum: 50 }

  def own?(object)
    id == object&.user_id
  end

  def own?(comment)
    comment.user_id == id
  end
end
