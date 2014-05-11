json.array!(@users) do |user|
  json.extract! user, :id
  if user.social_profile
  json.social_profile do |json|
    json.(user.social_profile, :name, :surname, :vk_access_token)
  end
  end
end
