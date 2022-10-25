class Public::PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = @post.id
    if comment.save
      render :post_comments # render先にjsファイルを指定
    else
      render "posts/show"
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = PostComment.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
      render :post_comments  # render先にjsファイルを指定
    else
      redirect_to post_path(@post)
      flash[:notice] = "他のユーザーのコメントは削除できません。"
    end
  end

  private
    def post_comment_params
      params.require(:post_comment).permit(:body)
    end
end
