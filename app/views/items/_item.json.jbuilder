json.extract! item, :id, :name, :description, :image_url, :storage, :status, :created_at, :updated_at
json.url item_url(item, format: :json)
