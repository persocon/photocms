PhotoCms::App.controllers :menus, :map => '/api/v1' do
  get :index, :map => 'menus', :provides => [:html, :json] do
    callback = params.delete('callback') # jsonp
  	@menus = MenuHelper.get_all_json

  	GeneralHelper.response_to(callback, @menus).call(self)
  end

  get :menu, :with => :slug, :provides => [:html, :json] do 
  	callback = params.delete('callback') # jsonp

  	@menus = MenuHelper.get_menu(params[:slug])

  	GeneralHelper.response_to(callback, @menus).call(self)
  end
end