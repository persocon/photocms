PhotoCms::App.controllers :tags, :map => '/api/v1', :cache => true do
	get :index, :map => 'tags', :provides => [:html, :json] do
		callback = params.delete('callback') # jsonp
		cache_key
		@tags = TagHelper.get_all_json
	
		GeneralHelper.response_to(callback, @tags).call(self)
		
	end

	get :tag, :with => :slug, :provides => [:html, :json] do
		callback = params.delete('callback')
		cache_key
		@tag = Tag.where(:slug => params[:slug]).first
		@contents = ContentHelper.get_from_tag(@tag.id)

		GeneralHelper.response_to(callback, @contents).call(self)
	end
end