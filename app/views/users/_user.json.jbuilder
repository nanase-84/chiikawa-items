json.extract! user, :id, :name, :email, :password, :profile_image, :birthday, :created_at, :updated_at
json.url user_url(user, format: :json)
