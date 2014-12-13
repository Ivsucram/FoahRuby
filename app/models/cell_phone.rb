class CellPhone 
	include Mongoid::Document
  	include Mongoid::Timestamps

  	field :phone_uid
  	field :active, default: false
  	scope :activated, ->{ where(active: true) }

  	belongs_to :user
end