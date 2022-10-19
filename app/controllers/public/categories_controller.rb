class Public::CategoriesController < ApplicationController
before_action :user_sign_in?

  def index
    @large_categories = LargeCategory.all
  end

  def get_item_category
    item_category = ItemCategory.where(large_category_id: params[:large_category_id])
    respond_to do |format|
      format.json { render json: item_category }
    end
  end

  def user_sign_in?
    unless user_signed_in?
      redirect_to new_user_session_path
      flash[:notice] = "サイトを使用するにはログインをしてください。"
    end
  end

end
