class Admin::UsersController < ApplicationController

  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
  end

  def edit
  end

  def update
  end

end
