class Admin::HomesController < ApplicationController
  before_action :admin_sign_in?

  def top
    #投稿一覧画面の並び替え表示
    if params[:latest]
      @posts = Post.latest.page(params[:page]).per(24)
    elsif params[:old]
      @posts = Post.old.page(params[:page]).per(24)
    elsif params[:rate_count]
      @posts = Post.rate_count.page(params[:page]).per(24)
    else
      @posts = Post.page(params[:page]).per(24)
    end
    @total_posts = Post.count
  end

  private

  def admin_sign_in?
    unless admin_signed_in?
      redirect_to new_admin_session_path
      flash[:notice] = "サイトを使用するにはログインをしてください"
    end
  end

end
