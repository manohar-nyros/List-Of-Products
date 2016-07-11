class ExampleMailer < ApplicationMailer
	def sent_product(list)
		@list = list
		mail(to: "manoharv225@gmail.com", subject: "test mail")
	end
end