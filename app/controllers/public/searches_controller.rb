class Public::SearchesController < ApplicationController
before_action :user_sign_in?

  def search
    #検索モデルUser or Postで条件分岐
    @range = params[:range]
    if @range == "User"
      @users = User.looks(params[:search], params[:word])
    else
      @posts = Post.looks(params[:search], params[:word])
    end
  end

  def large_category_search
    @large_category = LargeCategory.find(params[:id])
    @large_category_posts = @large_category.posts.page(params[:page]).per(8)
  end

  def item_category_search
    @item_category = ItemCategory.find(params[:id])
    @item_category_posts = @item_category.posts.page(params[:page]).per(8)
  end

  def user_sign_in?
    unless user_signed_in?
      redirect_to new_user_session_path
      flash[:notice] = "サイトを使用するにはログインをしてください"
    end
  end

end
