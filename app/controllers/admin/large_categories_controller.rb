class Admin::LargeCategoriesController < ApplicationController
  before_action :admin_sign_in?

  def index
    @large_categories = LargeCategory.all
    @large_category = LargeCategory.new
  end

  def create
    @large_category = LargeCategory.new(large_category_params)
    if @large_category.save
      flash[:notice] = "登録が完了しました。"
      redirect_to admin_large_categories_path
    else
      @large_categories = LargeCategory.all
      flash[:notice] = "カテゴリ(大分類)名を入力してください。"
      render :index
    end
  end

  def edit
    @large_category = LargeCategory.find(params[:id])
  end

  def update
    @large_category = LargeCategory.find(params[:id])
    if @large_category.update(large_category_params)
      flash[:notice] = "更新が完了しました。"
      redirect_to admin_large_categories_path
    else
      flash[:notice] = "カテゴリ(大分類)名を入力してください。"
      render :edit
    end
  end

  def destroy
    large_category = LargeCategory.find(params[:id])
    large_category.destroy
    redirect_to admin_large_categories_path
  end

  private

  def large_category_params
    params.require(:large_category).permit(:name)
  end

  def admin_sign_in?
    unless admin_signed_in?
      redirect_to new_admin_session_path
      flash[:notice] = "サイトを使用するにはログインをしてください。"
    end
  end

end
