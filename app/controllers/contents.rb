PhotoCms::App.controllers :contents, :map => '/api/v1/sets' do
	get :index, :provides => [:html, :json] do
		callback = params.delete('callback') # jsonp
		@contents = Content.where(:type => 'post').order(:sort).all
		@contents.map {|content| content.tags }
		json = @contents.map {|content| 
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
		json = json.to_json

		if callback
	      content_type :js
	      response = "#{callback}(#{json})" 
	    else
	      content_type :json
	      response = json
	    end
	    response
	end
end