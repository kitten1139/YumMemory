class Public::SearchesController < ApplicationController
  before_action :user_sign_in?

  def search
    # 検索モデルUser or Postで条件分岐
    @range = params[:range]
    if @range == "User"
      @users = User.looks(params[:word])
    else
      @posts = Post.privacy.looks(params[:word])
    end
  end

  def large_category_search
    @large_category = LargeCategory.find(params[:id])
  end

  def item_category_search
    @item_category = ItemCategory.find(params[:id])
  end

  def user_sign_in?
    unless user_signed_in?
      redirect_to new_user_session_path
      flash[:alert] = "サイトを使用するにはログインをしてください。"
    end
  end
end
