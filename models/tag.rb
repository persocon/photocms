class Tag < Sequel::Model
	unrestrict_primary_key
	
	many_to_many :contents

	# Callbacks
	def before_create
		sluger = Sluger.new
		sluger.slugfy(self)
	end

	def after_save
		clear_cache
	end

	def clear_cache
		@contents = Content.eager_graph(:tags).where(:tag_id => self.id, :type => 'post').all
		
		@contents.each_with_index do |content|
			PhotoCms::App.cache.delete("/api/v1/set/#{content.slug}")
		end
		
		PhotoCms::App.cache.delete("/api/v1/sets")

		PhotoCms::App.cache.delete("/api/v1/tags")
	end
	
	private
	
	def self.create_for_content(tags)
		tags_array = tags.split(",")
		tarray = []
		tags_array.each do |tag|
			t = Tag.find_or_create({
				:title => tag.strip, :slug => tag.to_url
			})
			tarray << t
		end
		tarray
	end
	

end
