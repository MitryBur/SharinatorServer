json.array!(@socials) do |social|
  json.extract! social, :name, :surname, :vk_id
  json.url v1_social_url(social, format: :json)
end
