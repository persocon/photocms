class ContentHelper

	def self.get_all_json
		contents = Content.where(:type => 'post', :published => true).order(:sort).all
		json = contents.map {|content| 
								{
									"id" => content[:id],
									"title" => content[:title],
									"slug" => content[:slug],
									"body" => content[:body],
									"tags" => GeneralHelper::map_tag(content.tags.map),
									"categories" => GeneralHelper::map_category(content.categories.map),
									"images" => GeneralHelper::map_upload(content.uploads.map)
								}
							}
		json.to_json
	end

	def self.get_set(slug)
		contents = Content.where(:type => 'post', :published => true, :slug => slug)
		json = contents.map {|content| 
								{
									"id" => content[:id],
									"title" => content[:title],
									"slug" => content[:slug],
									"body" => content[:body],
									"tags" => GeneralHelper::map_tag(content.tags.map),
									"categories" => GeneralHelper::map_category(content.categories.map),
									"images" => GeneralHelper::map_upload(content.uploads.map)
								}
							}
		json.to_json
	end

end