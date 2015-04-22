class Car < ActiveRecord::Base
	validates :price, numericality: {greater_than: 0}
	validates :stock, numericality: true

	def total_value
		price * stock
	end

	def self.get_most_expensive_car
		order(price: :desc).first
	end
end
