class Api
  include Mongoid::Document

  field  :label, type: String
  field  :desc, type:  String
  field  :cleintContent, type:String
end
