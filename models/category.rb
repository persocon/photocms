class Category < Sequel::Model

	many_to_many :contents
	
	# Callbacks
	def before_save
		slugfy
	end
	
	private
	
	def slugfy
		#if slug was typed do slugfy
		unless slug.nil? || slug.blank?
			self.slug = find_slugs slug.to_url
			#if there's no slug typed try to get the title
		else title.present?
				self.slug = find_slugs title.to_url
		end
	end
	
	def find_slugs(slug)
		num_of_slugs = Content.select(:slug, :id).where(:slug => slug).exclude(:id => id).all.count.to_int
		#check if num_of_slugs returned something
		if num_of_slugs > 0
			return "#{slug}-#{num_of_slugs}"
		else
			return slug
		end
	end

end
