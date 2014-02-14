class Tag < Sequel::Model
	unrestrict_primary_key
	
	many_to_many :contents

	# Callbacks
	def before_create
		sluger = Sluger.new
		sluger.slugfy(self)
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
