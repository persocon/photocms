PhotoCms::App.controllers :categories, :map => '/api/v1' do
	
	get :index, :map => 'categories', :provides => [:html, :json] do
	
		callback = params.delete('callback') # jsonp

		@categories = CategoryHelper.get_all_json
		
	
		if callback
			content_type :js
			response = "#{callback}(#{@categories})" 
		else
			content_type :json
			response = @categories
		end
		
		response
			
	end
	
end