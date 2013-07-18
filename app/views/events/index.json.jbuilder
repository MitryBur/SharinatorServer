json.array!(@events) do |event|
  json.extract! event, :title, :owner_id, :description
  json.url event_url(event, format: :json)
end
