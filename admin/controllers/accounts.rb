PhotoCms::Admin.controllers :accounts do
  get :index do
    @title = "Accounts"
    @accounts = Account.all
    redirect(url(:accounts, :edit, :id => current_account.id))
    # render 'accounts/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'account')
    @account = Account.new
    render 'accounts/new'
  end

  get :tumblr do 
    @consumer_key = current_account.tumblr_oauth_consumer_key
    @consumer_secret = current_account.tumblr_oauth_secret_key

    consumer = OAuth::Consumer.new(
      @consumer_key,
      @consumer_secret,
      { :site => 'http://www.tumblr.com',
        :request_token_path => '/oauth/request_token',
        :authorize_path => '/oauth/authorize',
        :access_token_path => '/oauth/access_token',
        :http_method => :get
       }
    )
    if params[:oauth_token] && params[:oauth_verifier]
      access_token = session[:request_token].get_access_token({:oauth_verifier => params[:oauth_verifier]})
      @user = Account[current_account.id]
      @user.tumblr_token = access_token.params[:oauth_token]
      @user.tumblr_token_secret = access_token.params[:oauth_token_secret]
      if @user.save
        flash[:success] = "Account associated with tumblr"
        redirect(url(:accounts, :edit, :id => current_account.id))
      end
    else
      request_token = consumer.get_request_token(:exclude_callback => true)
      session[:request_token] = request_token
      redirect session[:request_token].authorize_url
    end
  end

  post :create do
    @account = Account.new(params[:account])
    if (@account.save rescue false)
      @title = pat(:create_title, :model => "account #{@account.id}")
      flash[:success] = pat(:create_success, :model => 'Account')
      params[:save_and_continue] ? redirect(url(:accounts, :index)) : redirect(url(:accounts, :edit, :id => @account.id))
    else
      @title = pat(:create_title, :model => 'account')
      flash.now[:error] = pat(:create_error, :model => 'account')
      render 'accounts/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "account #{params[:id]}")
    @account = Account[params[:id]]
    if @account
      render 'accounts/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'account', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "account #{params[:id]}")
    @account = Account[params[:id]]
    if @account
      if @account.modified! && @account.update(params[:account])
        flash[:success] = pat(:update_success, :model => 'Account', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:accounts, :index)) :
          redirect(url(:accounts, :edit, :id => @account.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'account')
        render 'accounts/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'account', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Accounts"
    account = Account[params[:id]]
    if account
      if account != current_account && account.destroy
        flash[:success] = pat(:delete_success, :model => 'Account', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'account')
      end
      redirect url(:accounts, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'account', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Accounts"
    unless params[:account_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'account')
      redirect(url(:accounts, :index))
    end
    ids = params[:account_ids].split(',').map(&:strip)
    accounts = Account.where(:id => ids)
    
    if accounts.include? current_account
      flash[:error] = pat(:delete_error, :model => 'account')
    elsif accounts.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Accounts', :ids => "#{ids.to_sentence}")
    end
    redirect url(:accounts, :index)
  end
end
