class Public::PostsController < ApplicationController
  before_action :authenticate_user!

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
      flash[:notice] = "商品の投稿に失敗しました"
      @large_categories = LargeCategory.all
      @post = Post.new
      render :new
    end
  end

  def index
    @posts = Post.page(params[:page]).per(6)
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
    @item_category = ItemCategory.find(@post.item_category_id)
    @large_category = LargeCategory.find(@item_category.large_category_id)
    @item_categories = ItemCategory.where(large_category_id: @large_category.id)
    @large_categories = LargeCategory.all
  end

  def update
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:item_category_id, :rate, :review_title, :review_body, :item_name, :item_image)
  end

end
