json.array!(@events) do |event|
  json.extract! event, :id, :title, :owner_id, :description
  json.url v1_event_url(event, format: :json)
end
