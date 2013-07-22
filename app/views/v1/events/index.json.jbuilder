json.array!(@events) do |event|
  json.extract! event, :id, :title, :owner_id, :description
  json.members event.users do |json, user|
    json.(user, :id)
    json.social do |json|
      json.(user.social, :vk_id, :name, :surname)
     end
   end
end
