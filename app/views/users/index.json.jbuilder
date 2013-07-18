json.array!(@users) do |user|
  json.extract! user, :id
  json.url user_url(user, format: :json)
  json.social do |json|
    json.(user.social, :vk_id, :name, :surname)
  end
end
