class PageHelper

	def self.get_all_json
		contents = Content.where(:type => 'page', :published => true).order(:sort).all
		json = contents.map {|content| 
								{
									"id" => content[:id],
									"title" => content[:title],
									"slug" => content[:slug],
									"images" => GeneralHelper::map_upload(content.uploads.map)
								}
							}
		json.to_json
	end

	def self.get_page(slug)
		contents = Content.where(:type => 'page', :published => true, :slug => slug)
		json = contents.map {|content| 
								{
									"id" => content[:id],
									"title" => content[:title],
									"slug" => content[:slug],
									"body" => content[:body],
									"images" => GeneralHelper::map_upload(content.uploads.map)
								}
							}
		json.to_json
	end

end