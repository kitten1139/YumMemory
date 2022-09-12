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

end
