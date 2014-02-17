json.array!(@events) do |event|
  json.extract! event, :id, :title, :owner_id, :description
  json.users event.users do |user|
    if user
        json.(user, :id)
        if user.social_profile
            json.social_profile do |json|
                json.(user.social_profile, :vk_id, :name, :surname, :vk_access_token)
            end
        end
    end
   end
end
