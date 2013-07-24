json.extract! @expense, :title, :event_id, :amount, :description
json.users @expense.users do |user|
  json.(user, :id)
  json.social do |json|
    json.(user.social, :vk_id, :name, :surname)
   end
end