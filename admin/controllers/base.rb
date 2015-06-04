PhotoCms::Admin.controllers :base do
  get :index, :map => "/" do
    render "base/index"
  end

  get :resize, :map => "/resize-images" do
	Upload.all.each do |up|
		up.file.recreate_versions!
 	end
  	"sipa foi"
  end
end
