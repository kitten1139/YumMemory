class Public::PostFavoritesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    if @post.privacy == "1" && @post.user != current_user
      redirect_to posts_path
      flash[:notice] = "他のユーザーの非公開投稿はいいねできません。"
    else
      post_favorite = current_user.post_favorites.new(post_id: @post.id)
      post_favorite.save
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    post_favorite = current_user.post_favorites.find_by(post_id: @post.id)
    post_favorite.destroy
  end

end
