class FavoritesController < ApplicationController
  before_action :logged_in_user
  
  def create
    micropost = Micropost.find(params[:micropost_id])
    favorite = current_user.favorites.build(micropost: micropost)
    if favorite.save
      flash[:success] = "お気に入りに登録しました。"
      redirect_to root_path
      #redirect_to root_path, notice: "お気に入りに登録しました。"
    else
      flash[:danger] = "お気に入り登録に失敗しました。"
      redirect_to root_path
      #redirect_to root_path, alert: "お気に入り登録に失敗しました。"
    end
  end
  
  def destroy
    favorite = current_user.favorites.find_by(micropost_id: params[:micropost_id])
    favorite.destroy if favorite
    flash[:success] = "お気に入りを削除しました。"
    redirect_to root_path
  end
end