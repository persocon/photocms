PhotoCms::Admin.controllers :contents do
  get :index do
    @title = "Contents"
    @contents = Content.all
    render 'contents/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'content')
    @content = Content.new
    render 'contents/new'
  end

  post :create do    
    @content = Content.new(params[:content])
    #get current_user ID
    @content.account_id = current_account.id
    
    @content.created_at = @content.updated_at = DateTime.now
    
    if (@content.save rescue false)
      @title = pat(:create_title, :model => "content #{@content.id}")
      flash[:success] = pat(:create_success, :model => 'Content')
      params[:save_and_continue] ? redirect(url(:contents, :index)) : redirect(url(:contents, :edit, :id => @content.id))
    else
      @title = pat(:create_title, :model => 'content')
      flash.now[:error] = pat(:create_error, :model => 'content')
      render 'contents/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "content #{params[:id]}")
    @content = Content[params[:id]]
    if @content
      render 'contents/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'content', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "content #{params[:id]}")
    @content = Content[params[:id]]
    if @content
      #try to move this to model
      @tags = Tag.create_for_content(params[:tags])
      @content.remove_all_tags
      @tags.each do |tag|
      	 @content.add_tag(tag.id)
      end
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
    @title = "Contents"
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
    @title = "Contents"
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
