json.array!(@social_profiles) do |social_profile|
  json.extract! social_profile, :name, :surname, :vk_id
  json.url v1_social_profile_url(social_profile, format: :json)
end
