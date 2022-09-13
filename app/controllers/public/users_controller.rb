class Public::UsersController < ApplicationController
before_action :authenticate_user!
before_action :ensure_guest_user, only: [:edit]

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

  def my_posts
    @posts = current_user.posts.order(created_at: :desc).page(params[:page]).per(24)
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

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.nickname == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

end
