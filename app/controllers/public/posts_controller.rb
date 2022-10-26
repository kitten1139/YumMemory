class Public::PostsController < ApplicationController
  before_action :user_sign_in?
  before_action :ensure_guest_user, only: [:new, :create]

  def new
    @post = Post.new
    @large_categories = LargeCategory.all
  end

  def create
    @post = Post.new(post_params)
    # 送信されたレビュー内容からscoreを設定
    @post.score = Language.get_data(post_params[:review_body])
    @post.user = current_user
    if @post.save
      flash[:notice] = "商品を投稿しました。"
      redirect_to posts_path
    else
      flash[:alert] = "商品の投稿に失敗しました。*必須項目は必ず入力してください。"
      @large_categories = LargeCategory.all
      @post = Post.new
      render :new
    end
  end

  def index
    # 投稿一覧画面(公開投稿)の並び替え表示
    if params[:latest]
      @posts = Post.privacy.latest.page(params[:page]).per(24)
    elsif params[:old]
      @posts = Post.privacy.old.page(params[:page]).per(24)
    elsif params[:rate_count]
      @posts = Post.privacy.rate_count.page(params[:page]).per(24)
    elsif params[:post_favorite_count]
      posts = Post.privacy.post_favorite_count
      @posts = Kaminari.paginate_array(posts).page(params[:page]).per(24) # 配列に対してページャを作成
    else
      @posts = Post.privacy.page(params[:page]).per(24).order("created_at DESC")
    end
    @total_posts = Post.privacy.count
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    if @post.privacy == "1" && @post.user != current_user
      redirect_to posts_path
      flash[:alert] = "他のユーザーの非公開投稿は閲覧できません。"
    end
  end

  def edit
    @post = Post.find(params[:id])
    @item_category = ItemCategory.find(@post.item_category_id)
    @large_category = LargeCategory.find(@item_category.large_category_id)
    @item_categories = ItemCategory.where(large_category_id: @large_category.id)
    @large_categories = LargeCategory.all
    unless @post.user == current_user
      redirect_to post_path(@post)
      flash[:alert] = "他のユーザーの投稿は編集できません。"
    end
  end

  def update
    @post = Post.find(params[:id])
    # 送信されたレビュー内容からscoreを再設定
    @post.score = Language.get_data(post_params[:review_body])
    if @post.user != current_user
      redirect_to post_path(@post)
    else
      if @post.update(post_params)
        flash[:notice] = "変更を保存しました。"
        redirect_to posts_path
      else
        flash[:alert] = "変更に失敗しました。*必須項目は必ず入力してください。"
        @item_category = ItemCategory.find(@post.item_category_id)
        @large_category = LargeCategory.find(@item_category.large_category_id)
        @item_categories = ItemCategory.where(large_category_id: @large_category.id)
        @large_categories = LargeCategory.all
        render :edit
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user != current_user
      redirect_to post_path(@post)
      flash[:alert] = "他のユーザーの投稿は削除できません。"
    else
      @post.destroy
      flash[:notice] = "投稿を削除しました。"
      redirect_to posts_path
    end
  end

  private
    def post_params
      params.require(:post).permit(:item_category_id, :rate, :review_title, :review_body, :item_name, :item_image, :privacy, :store_name)
    end

    def user_sign_in?
      unless user_signed_in?
        redirect_to new_user_session_path
        flash[:alert] = "サイトを使用するにはログインをしてください。"
      end
    end

    def ensure_guest_user
      if current_user.email == "guest@example.com"
        redirect_to user_path(current_user)
        flash[:alert] = "ゲストユーザーは投稿できません。"
      end
    end
end
