class List < ActiveRecord::Base
before_save :vat_value
validates :product_id, uniqueness: true 
validates_numericality_of :price, :on => :create
validates :title,:description,:text, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
	def vat_value
		self.price *=  self.quantity
		self.vat = (self.price) * 0.2
		self.total = (self.price) + self.vat
	end
before_create :set_product_id
def set_product_id
	if List.count <1
		self.product_id = "PDCT-1001"
	else
	last_product_id = List.last.product_id.split('-').last.to_i + 1
	self.product_id = "PDCT-" + "#{last_product_id.to_s}"
	end
end
end