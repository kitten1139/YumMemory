class Public::PostCommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = @post.id
    if comment.save
      render :post_comments #render先にjsファイルを指定
    else
      render "posts/show"
    end
  end

  def destroy
    PostComment.find(params[:id]).destroy
    @post = Post.find(params[:post_id])
    render :post_comments  #render先にjsファイルを指定
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:body)
  end

end
