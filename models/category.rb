class Category < Sequel::Model

	many_to_many :contents
	
	# Callbacks
	def before_save
		sluger = Sluger.new
		sluger.slugfy(self)
	end

end
