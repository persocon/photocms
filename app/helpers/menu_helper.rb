class MenuHelper

	def self.get_all_json
		menus = Menu.all
		json = menus.map {|menu| 
								{
									"id" => menu[:id],
									"slug" => menu[:slug],
									"title" => menu[:title],
									"data" => menu[:data]
								}
							}
		json.to_json
	end

	def self.get_menu(slug)
		menu = Menu.where(:slug => slug)
		json = menu.map {|menu| 
								{
									"id" => menu[:id],
									"slug" => menu[:slug],
									"title" => menu[:title],
									"data" => menu[:data]
								}
							}
		json.to_json
	end
end