PhotoCms::Admin.controllers :contents do
  
  get :uploads, :with => :id do
    
    content = Content[params[:id]]
    @uploads = content.uploads.sort_by{|key| key[:sort]}
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
    @title = "Sets"
    @contents = Content.where(:type => 'post').order(:sort).all
    render 'contents/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'set')
    @content = Content.new
    @categories = Category.all
    @uploads_all = Upload.all
    @js = ['jquery.sortable.min']
    render 'contents/new'
  end
  
  get :sort do
    @title = pat(:sort_sets, :model => 'set')
    @contents = Content.where(:type => 'post').order(:sort).all
    @js = ['jquery.sortable.min']
    render 'contents/sort'
  end
  
  put :sort do
    params[:sort].each_with_index do |item, index|
      content = Content[item]
      content.sort = index
      content.save
    end
    redirect(url(:contents, :sort))
  end

  put :sortUpload do
    sorted = JSON.parse(params[:sorted])
    sorted.each_with_index do |item, index|
      upload = Upload[item]
      upload.sort = index
      upload.save
    end
    {success: true}.to_json
  end

  post :create do    
    @content = Content.new(params[:content])
    #get current_user ID
    @content.account_id = current_account.id
    
    @content.created_at = @content.updated_at = DateTime.now
    
    if (@content.save rescue false)
      
      @content.add_tags(params[:tags])
      @content.add_categories(params[:categories])
      @content.add_uploads(params[:uploads])
      
      @title = pat(:create_title, :model => "set #{@content.title}")
      flash[:success] = pat(:create_success, :model => 'Content')
      params[:save_and_continue] ? redirect(url(:contents, :index)) : redirect(url(:contents, :edit, :id => @content.id))
    else
      @title = pat(:create_title, :model => 'content')
      flash.now[:error] = pat(:create_error, :model => 'content')
      render 'contents/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "set #{params[:id]}")
    @js = ['jquery.sortable.min']
    @categories = Category.all
    @content = Content[params[:id]]
    @uploads_all = Upload.all
    if @content
      render 'contents/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'content', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "set #{params[:id]}")
    @content = Content[params[:id]]
    if @content
      
      @content.add_tags(params[:tags])
      @content.add_categories(params[:categories])
      @content.add_uploads(params[:uploads])
      
      @content.updated_at = DateTime.now
      if @content.modified! && @content.update(params[:content])
        flash[:success] = pat(:update_success, :model => 'Content', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:contents, :index)) :
          redirect(url(:contents, :edit, :id => @content.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'content')
        render 'contents/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'content', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Sets"
    content = Content[params[:id]]
    if content
      if content.destroy
        flash[:success] = pat(:delete_success, :model => 'Content', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'content')
      end
      redirect url(:contents, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'content', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Sets"
    unless params[:content_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'content')
      redirect(url(:contents, :index))
    end
    ids = params[:content_ids].split(',').map(&:strip)
    contents = Content.where(:id => ids)
    
    if contents.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Contents', :ids => "#{ids.to_sentence}")
    end
    redirect url(:contents, :index)
  end
end
