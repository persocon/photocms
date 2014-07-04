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

	def self.map_and_check_upload(featured_image_id, uploads)
		if uploads.any?
			response = uploads.map { |image|
				next if image.id == featured_image_id
				{
					"id" => image[:id],
					"files" => {
						"name" => image[:file],
						"default" => image.file.url,
						"thumb" => image.file.thumb.url,
						"thumb50" => image.file.thumb.thumb50.url
					}
				}
			}.compact
		else
			response = nil
		end
		response
	end

	def self.map_featured_upload(featured_image_id)
		unless featured_image_id.nil?
			image = Upload[featured_image_id]
			response = {
				"id" => image[:id],
				"files" => {
					"name" => image[:file],
					"default" => image.file.url,
					"thumb" => image.file.thumb.url,
					"thumb50" => image.file.thumb.thumb50.url
				}
			}
		else
			response = nil
		end
		response
	end

	def self.map_content(contents, random = nil)
		if contents.any?
			response = contents.map { |content|
				{
					"id" => content[:id],
					"title" => content[:title],
					"slug" => content[:slug],
					"body" => content[:body],
					"tags" => GeneralHelper::map_tag(content.tags.map),
					"categories" => GeneralHelper::map_category(content.categories.map),
					"featured_image" => GeneralHelper::map_featured_upload(content[:featured_image_id]),
					"images" => GeneralHelper::map_upload(content.uploads.map)
				}
			}
			if random
				response = response.sample(1)
			end
		else
			response = nil
		end

		response
	end

	def self.map_single_content(contents, random = nil)
		if contents.any?
			response = contents.map { |content|
				{
					"id" => content[:id],
					"title" => content[:title],
					"slug" => content[:slug],
					"body" => content[:body],
					"tags" => GeneralHelper::map_tag(content.tags.map),
					"categories" => GeneralHelper::map_category(content.categories.map),
					"featured_image" => GeneralHelper::map_featured_upload(content[:featured_image_id]),
					"images" => GeneralHelper::map_and_check_upload(content[:featured_image_id], content.uploads.map)
				}
			}
			if random
				response = response.sample(1)
			end
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