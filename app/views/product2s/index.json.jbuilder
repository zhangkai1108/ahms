json.array!(@product2s) do |product2|
  json.extract! product2, :id, :name
  json.url product2_url(product2, format: :json)
end
