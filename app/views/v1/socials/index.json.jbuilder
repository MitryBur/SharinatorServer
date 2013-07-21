json.array!(@socials) do |social|
  json.extract! social, :name, :surname, :social_id
  json.url social_url(social, format: :json)
end
