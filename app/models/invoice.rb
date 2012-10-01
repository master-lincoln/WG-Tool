class Invoice < ActiveRecord::Base
	belongs_to :creator, :class_name => "User"
	has_many :duties
	has_many :users, :through => :duties

	validates :comment, :price, :presence => true

	def individual_sum
		price / duties.count
	end

end
