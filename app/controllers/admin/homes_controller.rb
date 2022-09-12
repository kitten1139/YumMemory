class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @posts = Post.page(params[:page]).per(6)
    @total_posts = Post.count
  end

end
