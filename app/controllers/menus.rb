PhotoCms::App.controllers :menus, :map => '/api/v1', :cache => true do
  get :index, :map => 'menus', :provides => [:html, :json] do
    "nop"
  end

  get :menu, :with => :slug, :provides => [:html, :json] do 
  	callback = params.delete('callback') # jsonp
    #cache_key

  	@menus = MenuHelper.get_menu(params[:slug])

  	GeneralHelper.response_to(callback, @menus).call(self)
  end
end