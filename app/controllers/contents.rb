PhotoCms::App.controllers :contents, :map => '/api/v1/sets' do
	get :index, :provides => [:html, :json] do
		callback = params.delete('callback') # jsonp
		#params[:paged]
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