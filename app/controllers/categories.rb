PhotoCms::App.controllers :categories, :map => '/api/v1' do
	
	get :index, :map => 'categories', :provides => [:html, :json] do
	
		callback = params.delete('callback') # jsonp

		@categories = CategoryHelper.get_all_json
		
	
		GeneralHelper.response_to(callback, @categories).call(self)
			
	end
	
end