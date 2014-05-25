PhotoCms::App.controllers :tags, :map => '/api/v1' do
	get :index, :map => 'tags', :provides => [:html, :json] do
		callback = params.delete('callback') # jsonp
		@tags = TagHelper.get_all_json
	
		if callback
			content_type :js
			response = "#{callback}(#{@tags})" 
		else
			content_type :json
			response = @tags
		end
		
		response
		
	end
end