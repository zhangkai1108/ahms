class Product
  include Mongoid::Document
  field :name, type: String
  field :type, type: String
end
