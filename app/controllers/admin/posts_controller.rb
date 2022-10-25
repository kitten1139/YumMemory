class Admin::PostsController < ApplicationController
  before_action :admin_sign_in?

  def show
    @post = Post.find(params[:id])
    if @post.privacy == "1" && admin_signed_in?
      redirect_to admin_path
      flash[:notice] = "非公開投稿は閲覧できません。"
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_path
  end

  def comment_destroy
    @post = Post.find(params[:post_id])
    post_comment = @post.post_comments.find(params[:id])
    post_comment.destroy
    render :post_comments  # render先にjsファイルを指定
  end

  private
    def admin_sign_in?
      unless admin_signed_in?
        redirect_to new_admin_session_path
        flash[:notice] = "サイトを使用するにはログインをしてください。"
      end
    end
end
