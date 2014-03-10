class DealTask
  include Mongoid::Document
  field :dealDate, type: Date
  field :dealType, type: String
end
