class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    posts_path
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :gender, :age, :prefecture, :introduction, :favorite_food])
      devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :gender, :age, :prefecture, :introduction, :favorite_food])
    end
end
