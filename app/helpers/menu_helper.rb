class MenuHelper

	def self.get_all_json
		menus = Menu.all
		if menus.any?
			json = menus.map {|menu| 
									{
										"id" => menu[:id],
										"slug" => menu[:slug],
										"title" => menu[:title],
										"data" => MenuHelper::menu_data(JSON.parse(menu.data))
									}
								}
		else
			json = {}
		end							
		json.to_json
	end

	def self.get_menu(slug)
		menu = Menu.where(:slug => slug)
		if menu.any?
			json = menu.map {|menu| 
									{
										"id" => menu[:id],
										"slug" => menu[:slug],
										"title" => menu[:title],
										"children" => MenuHelper::menu_data(JSON.parse(menu.data))
									}
								}
		else
			json = {}
		end
		json.to_json
	end

	def self.menu_data(menu)
		unless menu.nil?
			result = menu.map{|item|
				{
					"id" => item["id"],
					"slug" => item["slug"],
					"url" => item["url"],
					"type" => item["type"],
					"is_external" => item["type"] === "external_link",
					"title" => recovery_title(item["title"], item["id"], item["type"]),
					"children" => menu_data(item["children"])
				}.compact
			}
			response = result
		else
			response = nil
		end
		response
	end


	def self.recovery_title(title, id, type)
		unless id.blank?
			if id == 0
				return title
			else
				unless type.blank?
					if type === "set" || type === "page"
						content = Content[id]
						return content.title
					end

					if type === "category"
						category = Category[id]
						return category.title
					end

					if type === "tag"
						tag = Tag[id]
						return tag.title
					end
				else
					return title
				end
			end
		else
			return title
		end
	end
end