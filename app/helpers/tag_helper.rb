class TagHelper

	def self.get_all_json
		categories = Tag.all
		json = categories.map {|category|

				{
					"id" => category[:id],
					"title" => category[:title],
					"slug" => category[:slug],
				}
		}	
		json.to_json
	end
end