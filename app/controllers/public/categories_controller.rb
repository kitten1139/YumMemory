class Public::CategoriesController < ApplicationController
  def index
    @large_categories = LargeCategory.all
  end
end
