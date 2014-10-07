json.array!(@calls) do |call|
  json.extract! call, :id, :cell_phone, :call_reminder, :event_recurrence_id
  json.url call_url(call, format: :json)
end
