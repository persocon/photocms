PhotoCms::App.controllers :menus, :map => '/api/v1' do
  get :index, :map => 'menus', :provides => [:html, :json] do
    callback = params.delete('callback') # jsonp
	@menus = MenuHelper.get_all_json

	if callback
      content_type :js
      response = "#{callback}(#{@menus})" 
    else
      content_type :json
      response = @menus
    end
    response
  end

  get :menu, :with => :slug, :provides => [:html, :json] do 
  	callback = params.delete('callback') # jsonp

  	@menus = MenuHelper.get_menu(params[:slug])

  	if callback
      content_type :js
      response = "#{callback}(#{@menus})" 
    else
      content_type :json
      response = @menus
    end
    response
  end
end