json.array!(@product1s) do |product1|
  json.extract! product1, :id, :name
  json.url product1_url(product1, format: :json)
end
