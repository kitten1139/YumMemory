class Admin::ItemCategoriesController < ApplicationController
  before_action :admin_sign_in?

  def index
    @large_category = LargeCategory.find(params[:large_category_id])
    #空白値は表示しない
    @item_categories = @large_category.item_categories.where.not(large_category_id: nil)
    @item_category = @item_categories.new
  end

  def create
    @large_category = LargeCategory.find(params[:large_category_id])
    @item_categories = @large_category.item_categories.where.not(large_category_id: nil)
    @item_category = @item_categories.new(item_category_params)
    if @item_category.save
      flash[:notice] = "登録が完了しました。"
      redirect_to admin_large_category_item_categories_path(@large_category)
    else
      flash[:notice] = "カテゴリ(小分類)名を入力してください。"
      render :index
    end
  end

  def edit
    @item_category = ItemCategory.find(params[:id])
  end

  def update
    @item_category = ItemCategory.find(params[:id])
    if @item_category.update(item_category_params)
      flash[:notice] = "更新が完了しました。"
      redirect_to admin_large_category_item_categories_path(@item_category.large_category)
    else
      flash[:notice] = "カテゴリ(小分類)名を入力してください。"
      render :edit
    end
  end

  def destroy
    item_category = ItemCategory.find(params[:id])
    item_category.destroy
    redirect_to admin_large_category_item_categories_path(item_category.large_category)
  end

  private

  def item_category_params
    params.require(:item_category).permit(:name)
  end

  def admin_sign_in?
    unless admin_signed_in?
      redirect_to new_admin_session_path
      flash[:notice] = "サイトを使用するにはログインをしてください。"
    end
  end

end
