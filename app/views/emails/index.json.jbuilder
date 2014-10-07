json.array!(@emails) do |email|
  json.extract! email, :id, :email, :event_recurrence_id
  json.url email_url(email, format: :json)
end
