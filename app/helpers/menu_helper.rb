class MenuHelper

	def self.get_all_json
		menus = Menu.all
		if menus.any?
			json = menus.map {|menu| 
									{
										"id" => menu[:id],
										"slug" => menu[:slug],
										"title" => menu[:title],
										"data" => MenuHelper::menu_data(menu)
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
										"data" => MenuHelper::menu_data(menu)
									}
								}
		else
			json = {}
		end
		json.to_json
	end

	def self.menu_data(menu)
		unless menu.data.nil?
			response = JSON.parse(menu[:data])
		else
			response = nil
		end
		response
	end
end