class Admin::ReviewsController < ApplicationController
  before_action :admin_sign_in?

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_path
  end

  def admin_sign_in?
    unless admin_signed_in?
      redirect_to new_admin_session_path
      flash[:notice] = "サイトを使用するにはログインをしてください"
    end
  end

end
