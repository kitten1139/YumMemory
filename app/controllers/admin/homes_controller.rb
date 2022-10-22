class Admin::HomesController < ApplicationController
  before_action :admin_sign_in?

  def top
    #投稿一覧画面の並び替え表示
    if params[:latest]
      @posts = Post.privacy.latest.page(params[:page]).per(24)
    elsif params[:old]
      @posts = Post.privacy.old.page(params[:page]).per(24)
    elsif params[:rate_count]
      @posts = Post.privacy.rate_count.page(params[:page]).per(24)
    elsif params[:score_count]
      @posts = Post.privacy.score_count.page(params[:page]).per(24)
    else
      @posts = Post.privacy.page(params[:page]).per(24).order("created_at DESC")
    end
    @total_posts = Post.privacy.count
  end

  private

  def admin_sign_in?
    unless admin_signed_in?
      redirect_to new_admin_session_path
      flash[:notice] = "サイトを使用するにはログインをしてください。"
    end
  end

end
