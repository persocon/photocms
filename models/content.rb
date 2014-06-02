class Content < Sequel::Model
	unrestrict_primary_key
	
	many_to_one :accounts
	many_to_many :tags
	many_to_many :uploads
	many_to_many :categories
	
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
	
	def add_uploads(uploads)
		if uploads.present?
			self.remove_all_uploads
			uploads.each do |upload|
				 self.add_upload(upload.to_i)
			end
		else
			self.remove_all_uploads
		end
	end
	
	def remove_associations
		self.remove_all_uploads
		self.remove_all_categories
		self.remove_all_tags
	end

	def clear_cache
		type = self.type
		if type == "page"
			PhotoCms::App.cache.delete("/api/v1/pages")
			PhotoCms::App.cache.delete("/api/v1/page/#{self.slug}")
		else
			PhotoCms::App.cache.delete("/api/v1/sets")
			PhotoCms::App.cache.delete("/api/v1/set/#{self.slug}")
		end
	end
end
