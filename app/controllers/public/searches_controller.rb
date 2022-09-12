class Public::SearchesController < ApplicationController

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
  end

  def item_category_search
    @item_category = ItemCategory.find(params[:id])
    @item_category_posts = @item_category.posts.page(params[:page]).per(8)
  end

end
