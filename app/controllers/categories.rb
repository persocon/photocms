PhotoCms::App.controllers :categories, :map => '/api/v1', :cache => true do
	
	get :index, :map => 'categories', :provides => [:html, :json] do
	
		callback = params.delete('callback') # jsonp

		cache_key

		@categories = CategoryHelper.get_all_json
	
		GeneralHelper.response_to(callback, @categories).call(self)
			
	end

	get :category, :with => :slug, :provides => [:html, :json] do
		callback = params.delete('callback')
		cache_key
		@category = Category.where(:slug => params[:slug]).first
		@contents = ContentHelper.get_from_category(@category.id)

		GeneralHelper.response_to(callback, @contents).call(self)
	end
	
end