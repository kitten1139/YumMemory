class Admin::HomesController < ApplicationController
  before_action :admin_sign_in?

  def top
    # 投稿一覧画面の並び替え表示
    if params[:latest]
      @posts = Post.privacy.latest.page(params[:page]).per(24)
    elsif params[:old]
      @posts = Post.privacy.old.page(params[:page]).per(24)
    elsif params[:post_favorite_count]
      posts = Post.privacy.post_favorite_count
      @posts = Kaminari.paginate_array(posts).page(params[:page]).per(24) # 配列に対してページャを作成
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
        flash[:alert] = "サイトを使用するにはログインをしてください。"
      end
    end
end
