class Market
  include Mongoid::Document
  field :name, type: String
  field :place, type: String
  field :currentDate, type: Date
  field :minPrice, type: Float
  field :maxPrice, type: Float
  field :avgPrice, type: Float
  field :unit, type: String
end
