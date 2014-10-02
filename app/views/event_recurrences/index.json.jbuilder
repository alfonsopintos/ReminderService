json.array!(@event_recurrences) do |event_recurrence|
  json.extract! event_recurrence, :id, :bill_id, :start_date, :end_date, :every
  json.url event_recurrence_url(event_recurrence, format: :json)
end
