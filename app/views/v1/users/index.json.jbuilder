json.array!(@users) do |user|
  json.extract! user, :id
  json.social_profile do |json|
    json.(user.social_profile, :name, :surname)
  end
end
