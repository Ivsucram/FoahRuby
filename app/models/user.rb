class User
	include Mongoid::Document
  	include Mongoid::Timestamps

  	field :mobile_number
  	field :name

  	has_many :cell_phones, :dependent => :destroy
  	validates :mobile_number, uniqueness: true

  	def self.find_by_number(number)
  		self.find_by(:mobile_number => number) rescue nil
  	end

end 