class List < ActiveRecord::Base
before_save :vat_value
validates :product_id, uniqueness: true 
validates_numericality_of :price, :on => :create
validates :title,:description,:text, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
has_attached_file :photo, 
styles: { thumb: "100x100>" }#, default_url: "/images/:style/missing.png",
#path: ":rails_root/public/images/:id/:filename",
# url: "/images/:id/:filename"

do_not_validate_attachment_file_type :photo
  # validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
	def vat_value
		self.price *=  self.quantity
		self.vat = (self.price) * 0.2
		self.total = (self.price) + self.vat
	end

def self.search(search)
  if search
    where('title LIKE ?', "%#{search}%")
  else
    all
  end
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
