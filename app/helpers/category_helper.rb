class CategoryHelper
	
	def self.get_all_json
		categories = Category.where(:parent_id => nil).all
		json = categories.map {|category|
					
				{
					"id" => category[:id],
					"title" => category[:title],
					"slug" => category[:slug],
					"children" => loop_again(category.children)
				}
		}	
		json.to_json
	end
	
	def self.loop_again(category)
		 unless category.blank? 
			json = category.map {|cat|
				{
					"id" => cat.id,
					"title" => cat.title,
					"slug" => cat.slug,
					"children" => loop_again(cat.children)
				}
			}
			json
		end 
	end
	
end