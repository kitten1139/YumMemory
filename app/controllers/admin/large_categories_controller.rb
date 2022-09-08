class Admin::LargeCategoriesController < ApplicationController
  def index
    @large_categories = LargeCategory.all
    @large_category = LargeCategory.new
  end

  def create
    @large_category = LargeCategory.new(large_category_params)
    if @large_category.save
      redirect_to admin_large_categories_path
    else
      @large_categories = LargeCategory.all
      render :index
    end
  end

  def edit
    @large_category = LargeCategory.find(params[:id])
  end

  def update
    @large_category = LargeCategory.find(params[:id])
    if @large_category.update(large_category_params)
      redirect_to admin_large_categories_path
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def large_category_params
    params.require(:large_category).permit(:name)
  end
end
