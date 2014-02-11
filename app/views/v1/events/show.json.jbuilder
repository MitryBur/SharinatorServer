json.extract! @event, :id, :title, :owner_id, :description
json.users @event.users do |user|
  json.(user, :id)
  json.social_profile do |json|
    json.(user.social_profile, :vk_id, :name, :surname)
  end
end
