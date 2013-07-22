json.array!(@members) do |member|
  json.extract! member, :user_id, :event_id
  json.url v1_member_url(member, format: :json)
end
