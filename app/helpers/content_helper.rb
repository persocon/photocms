class ContentHelper

	def self.get_all_json
		contents = Content.where(:type => 'post').order(:sort).all
		contents.map {|content| content.tags }
		json = contents.map {|content| 
								{
									"id" => content[:id],
									"title" => content[:title],
									"slug" => content[:slug],
									"tags" => content.tags.map {|tag| 
																	{ 
																		"id" => tag[:id],
																		"title" => tag[:title],
																		"slug" => tag[:slug]
																	}
															   },
									"categories" => content.categories.map {|category|
																				{
																					"id" => category[:id],
																					"parent_id" => category[:parent_id],
																					"title" => category[:title],
																					"slug" => category[:slug]
																				}
																		   },
									"images" => content.uploads.map { |image|
																		{
																			"id" => image[:id],
																			"files" => {
																				"name" => image[:file],
																				"default" => image.file.url,
																				"thumb" => image.file.thumb.url,
																				"thumb50" => image.file.thumb.thumb50.url
																			}
																		}
																	}
								}
							}
		json.to_json
	end

end