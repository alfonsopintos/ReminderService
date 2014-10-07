json.array!(@texts) do |text|
  json.extract! text, :id, :cell_phone, :text_reminder
  json.url text_url(text, format: :json)
end
