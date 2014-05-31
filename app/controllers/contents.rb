PhotoCms::App.controllers :contents, :map => '/api/v1', :cache => true do
	
	get :index, :map => 'sets', :provides => [:html, :json] do
		callback = params.delete('callback') # jsonp
		@contents = ContentHelper.get_all_json
		GeneralHelper.response_to(callback, @contents).call(self)
		cache_key :set
	end

	get :set, :with => :slug, :provides => [:html, :json] do
		callback = params.delete('callback') # jsonp
		@content = ContentHelper.get_set(params[:slug])

		GeneralHelper.response_to(callback, @content).call(self)
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