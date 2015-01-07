class Location
	include Mongoid::Document
  	include Mongoid::Timestamps

  	field :latitude, type: Float
  	field :longitude, type: Float
  	field :radius, type: Float

  	belongs_to :post
end