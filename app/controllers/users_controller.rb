class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    #初期化処理
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                  :password_confirmation)
  end
end
