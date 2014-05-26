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
	
end