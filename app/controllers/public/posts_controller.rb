class Public::PostsController < ApplicationController
  before_action :user_sign_in?
  before_action :ensure_guest_user, only:[:new, :create]

  def new
    @post = Post.new
    @large_categories = LargeCategory.all
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:notice] = "商品を投稿しました"
      redirect_to post_path(@post.id)
    else
      flash[:notice] = "商品の投稿に失敗しました。*必須項目は必ず入力してください。"
      @large_categories = LargeCategory.all
      @post = Post.new
      render :new
    end
  end

  def index
    @total_posts = Post.count
    #投稿一覧画面の並び替え表示
    if params[:latest]
      @posts = Post.latest.page(params[:page]).per(24)
    elsif params[:old]
      @posts = Post.old.page(params[:page]).per(24)
    elsif params[:rate_count]
      @posts = Post.rate_count.page(params[:page]).per(24)
    elsif params[:favorite_count]
      @posts = Post.favorite_count.page(params[:page]).per(24)
    else
      @posts = Post.page(params[:page]).per(24)
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
    @item_category = ItemCategory.find(@post.item_category_id)
    @large_category = LargeCategory.find(@item_category.large_category_id)
    @item_categories = ItemCategory.where(large_category_id: @large_category.id)
    @large_categories = LargeCategory.all
    unless @post.user == current_user
      redirect_to post_path(@post)
      flash[:notice] = "他のユーザーの投稿は編集できません"
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "変更を保存しました"
      redirect_to posts_path
    else
      flash[:notice] = "変更に失敗しました。*必須項目は必ず入力してください"
      @item_category = ItemCategory.find(@post.item_category_id)
      @large_category = LargeCategory.find(@item_category.large_category_id)
      @item_categories = ItemCategory.where(large_category_id: @large_category.id)
      @large_categories = LargeCategory.all
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:item_category_id, :rate, :review_title, :review_body, :item_name, :item_image)
  end

  def user_sign_in?
    unless user_signed_in?
      redirect_to new_user_session_path
      flash[:notice] = "サイトを使用するにはログインをしてください"
    end
  end

  def ensure_guest_user
    if current_user.email == "guest@example.com"
      redirect_to user_path(current_user)
      flash[:notice] = "ゲストユーザーは投稿できません。"
    end
  end

end
