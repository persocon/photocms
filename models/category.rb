class Category < Sequel::Model

	plugin :tree

	many_to_many :contents
	many_to_one :parent, :class=>self
	one_to_many :children, :key=>:parent_id, :class=>self
	
	# Callbacks
	def before_create
		sluger = Sluger.new
		sluger.slugfy(self)
	end

end
