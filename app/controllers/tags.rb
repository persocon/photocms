PhotoCms::App.controllers :tags, :map => '/api/v1' do
	get :index, :map => 'tags', :provides => [:html, :json] do
		callback = params.delete('callback') # jsonp
		@tags = TagHelper.get_all_json
	
		GeneralHelper.response_to(callback, @tags).call(self)
		
	end
end