class Public::CategoriesController < ApplicationController
before_action :authenticate_user!

  def index
    @large_categories = LargeCategory.all
  end

  def get_item_category
    item_category = ItemCategory.where(large_category_id: params[:large_category_id])
    respond_to do |format|
      format.json { render json: item_category }
    end
  end

end
