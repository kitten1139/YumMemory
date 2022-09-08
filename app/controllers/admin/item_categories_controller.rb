class Admin::ItemCategoriesController < ApplicationController
  def index
    @large_category = LargeCategory.find(params[:large_category_id])
    @item_categories = @large_category.item_categories
    @item_category = @item_categories.new
  end

  def create
    @large_category = LargeCategory.find(params[:large_category_id])
    @item_categories = @large_category.item_categories
    @item_category = @item_categories.new(item_category_params)
    if @item_category.save
      redirect_to admin_large_category_item_categories_path(@large_category)
    else
      render :index
    end
  end

  def edit
    @item_category = ItemCategory.find(params[:id])
    @large_category = @item_category.large_category
  end

  def update
    item_category = ItemCategory.find(params[:id])
    item_category.update
    redirect_to admin_large_category_item_categories_path(item_category.large_category)
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
end
