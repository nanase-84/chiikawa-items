# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Itemモデルのダミーデータ作成
10.times do
  item = Item.create!(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph,
    storage: Faker::Lorem.word,
    # image_url: ここでは仮にnilとする (後で画像をアップロード)
  )

  # タグの関連付け
  2.times do
    item.tags << Tag.find_or_create_by(name: Faker::Lorem.word)
  end
end
