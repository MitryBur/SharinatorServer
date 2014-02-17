json.extract! @user, :id, :created_at, :updated_at
json.social_profile do |json|
  json.(@user.social_profile, :name, :surname, :vk_id, :vk_access_token)
end
