class Post
	include Mongoid::Document
  	include Mongoid::Timestamps

  	field :message

  	belongs_to :user
  	has_one :location, :dependent => :destroy
end