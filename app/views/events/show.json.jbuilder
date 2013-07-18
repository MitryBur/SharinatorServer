json.extract! @event, :id, :title, :owner_id, :description
json.attendances @event.users do |json, user|
  json.(user, :id)
end
