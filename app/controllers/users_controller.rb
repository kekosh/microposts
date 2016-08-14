class UsersController < ApplicationController
  before_action :set_params, only: [:show, :edit, :update, :followings, :followers, :favorites]
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    #初期化処理
    @user = User.new
  end
  
  def create
    @user = User.new(new_user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(edit_user_params)
      flash[:success] = "Updated Profile!"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def followings
    @title = "followings_List"
    @users = @user.following_users
    render 'show_follower'
  end

  def followers
    @title = "followers_List"
    @users = @user.follower_users
    render 'show_follower'
  end

  def favorites
    @title = "favorite_posts"
    @favorites = @user.favorite_posts
    render 'show_favorite'
  end

  private
  
  def set_params
    @user = User.find(params[:id])
  end
  
  def correct_user
    redirect_to root_path if !current_user?(@user)
  end

  def new_user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def edit_user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,
                                  :age, :address, :remarks)
  end
end
