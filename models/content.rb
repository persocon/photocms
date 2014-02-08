class Content < Sequel::Model
	unrestrict_primary_key
	
	many_to_one :accounts
	many_to_many :tags
	many_to_many :uploads
	many_to_many :categories
	
	# Callbacks
	def before_save
		slugfy
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
