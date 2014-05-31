PhotoCms::App.controllers :contents, :map => '/api/v1' do
	get :index, :map => 'pages', :provides => [:html, :json] do
		callback = params.delete('callback') # jsonp
		@pages = PageHelper.get_all_json
		GeneralHelper.response_to(callback, @pages).call(self)
	end

	get :page, :with => :slug, :provides => [:html, :json] do
		callback = params.delete('callback') # jsonp
		@page = PageHelper.get_page(params[:slug])

		GeneralHelper.response_to(callback, @page).call(self)
	end

end