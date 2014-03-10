json.array!(@talks) do |talk|
  json.extract! talk, :id, :content
  json.url talk_url(talk, format: :json)
end
