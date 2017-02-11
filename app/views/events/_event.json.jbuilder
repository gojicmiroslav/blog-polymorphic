json.extract! event, :id, :name, :starts_at, :ends_at, :description, :created_at, :updated_at
json.url event_url(event, format: :json)