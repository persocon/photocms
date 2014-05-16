PhotoCms::App.controllers :contents, :map => '/api/v1/sets' do
	get :index do
		"render backbone app here"
	end

	get :all, :provides => [:html, :json] do
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
end