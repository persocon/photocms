class ContentHelper

	def self.get_all_json
		contents = Content.where(:type => 'post', :published => true).order(:sort).all
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

	def self.get_set(slug)
		contents = Content.where(:type => 'post', :published => true, :slug => slug)
		json = contents.map {|content| 
								{
									"id" => content[:id],
									"title" => content[:title],
									"slug" => content[:slug],
									"body" => content[:body],
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