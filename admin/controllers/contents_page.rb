PhotoCms::Admin.controllers :pages do

	get :uploads, :with => :id do

		content = Content[params[:id]]
		@uploads = content.uploads
		hash = Array.new
		@uploads.each do |upload|
			hash << {
				:id => upload.id,
				:filename => upload.file.url.split("/").last,
				:file => upload.file,
				:thumb => upload.file.thumb
			}
		end
		hash.to_json

	end

	get :index do
		@title = "Pages"
		@contents = Content.where(:type => 'page').order(:sort).all
		render 'pages/index'
	end

	get :new do
		@title = pat(:new_title, :model => 'content')
		@content = Content.new
		@uploads_all = Upload.all
		render 'pages/new'
	end

	get :sort do
		@title = pat(:sort_title, :model => 'content')
		@contents = Content.where(:type => 'page').order(:sort).all
		@js = ['jquery.sortable.min']
		render 'pages/sort'
	end

	put :sort do
		params[:sort].each_with_index do |item, index|
			content = Content[item]
			content.sort = index
			content.save
		end
		redirect(url(:pages, :sort))
	end

	post :create do    
		@content = Content.new(params[:content])
		#get current_user ID
		@content.account_id = current_account.id

		@content.created_at = @content.updated_at = DateTime.now

		if (@content.save rescue false)

			@content.add_uploads(params[:uploads])

			@title = pat(:create_title, :model => "content #{@content.id}")
			flash[:success] = pat(:create_success, :model => 'Content')
			params[:save_and_continue] ? redirect(url(:pages, :index)) : redirect(url(:pages, :edit, :id => @content.id))
		else
			@title = pat(:create_title, :model => 'content')
			flash.now[:error] = pat(:create_error, :model => 'content')
			render 'pages/new'
		end
	end

	get :edit, :with => :id do
		@title = pat(:edit_title, :model => "content #{params[:id]}")
		@content = Content[params[:id]]
		@uploads_all = Upload.all
		if @content
			render 'pages/edit'
		else
			flash[:warning] = pat(:create_error, :model => 'content', :id => "#{params[:id]}")
			halt 404
		end
	end

	put :update, :with => :id do
		@title = pat(:update_title, :model => "content #{params[:id]}")
		@content = Content[params[:id]]
		if @content
			
			@content.add_uploads(params[:uploads])

			@content.updated_at = DateTime.now
			if @content.modified! && @content.update(params[:content])
				flash[:success] = pat(:update_success, :model => 'Content', :id =>  "#{params[:id]}")
				params[:save_and_continue] ?
					redirect(url(:pages, :index)) :
					redirect(url(:pages, :edit, :id => @content.id))
			else
				flash.now[:error] = pat(:update_error, :model => 'content')
				render 'pages/edit'
			end
		else
			flash[:warning] = pat(:update_warning, :model => 'content', :id => "#{params[:id]}")
			halt 404
		end
	end

	delete :destroy, :with => :id do
		@title = "Pages"
		content = Content[params[:id]]
		if content
			if content.destroy
				flash[:success] = pat(:delete_success, :model => 'Content', :id => "#{params[:id]}")
			else
				flash[:error] = pat(:delete_error, :model => 'content')
			end
			redirect url(:pages, :index)
		else
			flash[:warning] = pat(:delete_warning, :model => 'content', :id => "#{params[:id]}")
			halt 404
		end
	end

	delete :destroy_many do
		@title = "Pages"
		unless params[:content_ids]
			flash[:error] = pat(:destroy_many_error, :model => 'content')
			redirect(url(:pages, :index))
		end
		ids = params[:content_ids].split(',').map(&:strip)
		contents = Content.where(:id => ids)

		if contents.destroy

			flash[:success] = pat(:destroy_many_success, :model => 'Contents', :ids => "#{ids.to_sentence}")
		end
		redirect url(:pages, :index)
	end
end
