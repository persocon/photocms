class Content < Sequel::Model
	unrestrict_primary_key
	
	many_to_one :accounts
	many_to_many :tags
	many_to_many :uploads
	many_to_many :categories
	
	# Callbacks
	def before_save
		sluger = Sluger.new
		sluger.slugfy(self)
	end
	
	def add_tags(tags)
		if tags.present?
			@tags = Tag.create_for_content(tags)
			self.remove_all_tags
			@tags.each do |tag|
				 self.add_tag(tag.id)
			end
		else
			self.remove_all_tags
		end
	end
	
	def add_categories(categories)
		if categories.present?
			self.remove_all_categories
			categories.each do |category|
				 self.add_category(category.to_i)
			end
		else
			self.remove_all_categories
		end
	end
	
end
