PhotoCms::App.controllers :contents, :map => '/api/v1' do
	get :index, :map => 'sets', :provides => [:html, :json] do
		callback = params.delete('callback') # jsonp
		@contents = ContentHelper.get_all_json

		if callback
	    content_type :js
	    response = "#{callback}(#{@contents})" 
	  else
	    content_type :json
	    response = @contents
	  end
	  
	  response
	end

	get :set, :with => :slug, :provides => [:html, :json] do
		callback = params.delete('callback') # jsonp
		@content = ContentHelper.get_set(params[:slug])

		if callback
			content_type :js
			response = "#{callback}(#{@content})"
		else
			content_type :json
			response = @content
		end
		
		response
	end

	get :page do
		# "teste #{params}"
		callback = params.delete('callback')

		if callback
	    content_type :js
	    response = "#{callback}(#{params.to_json})" 
	  else
	    content_type :json
	    response = params.to_json
	  end
	  
	  response
	  
	end
	
end