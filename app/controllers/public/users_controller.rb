class Public::UsersController < ApplicationController
before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    #編集するユーザーが本人でない場合はユーザー詳細ページにリダイレクトする
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user)
    else
      redirect_to edit_user_path(current_user)
    end
  end

  def confirm
    @user = current_user
  end

  def deleted
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :gender, :age, :prefecture, :introduction, :favorite_food, :profile_image)
  end

end
