json.extract! @expense, :title, :event_id, :price, :description
json.payer do |json|
  json.(@payer, :id, :created_at, :updated_at)
  json.social_profile do |json|
    json.(@payer.social_profile, :name, :surname, :vk_access_token)
  end
end
json.debtors @debtors do |debtor|
  json.(debtor, :id, :created_at, :updated_at)
  json.social_profile do |json|
    json.(debtor.social_profile, :name, :surname, :vk_access_token)
  end
end