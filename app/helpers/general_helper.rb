class GeneralHelper
	
	def self.response_to(callback,contents)
		response = {}
		if callback
			response[:content_type] = :js
	    	response[:body] = "#{callback}(#{contents})"
	  	else
	    	response[:content_type] = :json
	    	response[:body] = contents
	  	end
	  	lambda { |controller| 
	  		controller.content_type(response[:content_type])
	  		response[:body]
	  	}
	end
	
	def self.map_tag(tags)
		if tags.any?
			response = tags.map {|tag| 
					{ 
						"id" => tag[:id],
						"title" => tag[:title],
						"slug" => tag[:slug]
					}
				 }
		else
			response = nil
		end
		response
	end
	
	def self.map_category(categories)
		if categories.any?
			response = categories.map {|category|
				{
					"id" => category[:id],
					"parent_id" => category[:parent_id],
					"title" => category[:title],
					"slug" => category[:slug]
				}
			 }
		else
			response = nil
		end
		response
	end
	
	def self.map_upload(uploads)
		if uploads.any?
			response = uploads.map { |image|
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
		else
			response = nil
		end
		response
	end

	def self.map_content(contents)
		if contents.any?
			response = contents.map { |content|
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
		else
			response = nil
		end

		response
	end

	def self.map_page(contents)
		if contents.any?
			response = contents.map { |content|
				{
					"id" => content[:id],
					"title" => content[:title],
					"slug" => content[:slug],
					"body" => content[:body],
					"images" => GeneralHelper::map_upload(content.uploads.map)
				}
			}
		else
			response = nil
		end

		response
	end
	
end