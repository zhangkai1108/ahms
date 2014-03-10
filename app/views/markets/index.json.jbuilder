json.array!(@markets) do |market|
  json.extract! market, :id, :name, :place, :currentDate, :minPrice, :maxPrice, :avgPrice, :unit
  json.url market_url(market, format: :json)
end
