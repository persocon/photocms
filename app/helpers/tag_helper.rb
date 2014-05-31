class TagHelper

	def self.get_all_json
		tags = Tag.all
		json = GeneralHelper::map_tag(tags.map)
		json.to_json
	end
	
end