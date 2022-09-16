class Admin::HomesController < ApplicationController
  before_action :admin_sign_in?

  def top
    @posts = Post.page(params[:page]).per(24)
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
