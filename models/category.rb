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
	
	def before_destroy
		remove_associations
	end

	def after_save
		clear_cache
	end
	
	def remove_associations
		self.remove_all_contents
		self.remove_all_children
	end

	def clear_cache
		PhotoCms::App.cache.delete("/api/v1/categories")
	end

end
