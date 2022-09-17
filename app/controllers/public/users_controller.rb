class Public::UsersController < ApplicationController
before_action :user_sign_in?
before_action :ensure_guest_user, only: [:edit]

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    #編集するユーザーが本人でない場合はユーザー詳細ページにリダイレクトする
    unless @user == current_user
      redirect_to user_path(@user)
      flash[:notice] = "他のユーザーの情報は編集することができません"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "変更を保存しました"
      redirect_to user_path(current_user)
    else
      flash[:notice] = "変更に失敗しました。*必須項目は必ず入力してください"
      render :edit
    end
  end

  def confirm
    @user = current_user
  end

  def deleted
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会しました。ご利用ありがとうございました。"
    redirect_to root_path
  end

  def my_posts
    @posts = current_user.posts.page(params[:page]).per(24)
    @total_posts = @posts.total_count
  end

  def my_favorites
    @user = User.find(params[:user_id])
    post_favorites = PostFavorite.where(user_id: @user.id).pluck(:post_id)
    @posts = Post.where(id: post_favorites).page(params[:page]).per(24)
    @total_posts = @posts.total_count
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :gender, :age, :prefecture, :introduction, :favorite_food, :profile_image)
  end

  def user_sign_in?
    unless user_signed_in?
      redirect_to new_user_session_path
      flash[:notice] = "サイトを使用するにはログインをしてください"
    end
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
      redirect_to user_path(current_user)
      flash[:notice] = "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

end
