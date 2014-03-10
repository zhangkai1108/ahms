json.array!(@products) do |product|
  json.extract! product, :id, :name, :type
  json.url product_url(product, format: :json)
end
