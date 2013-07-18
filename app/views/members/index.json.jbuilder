json.array!(@members) do |member|
  json.extract! member, :user_id, :event_id
  json.url member_url(member, format: :json)
end
