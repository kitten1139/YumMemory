class Public::PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
    @item_categories = ItemCategory.all
  end

  def create
  end

  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
