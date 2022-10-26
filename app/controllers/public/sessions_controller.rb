# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # ログイン画面でcreateアクションが実行される前に確認を行う
  before_action :user_state, only: [:create]

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to posts_path
    flash[:notice] = "guestuserでログインしました。"
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  protected
    # ユーザーが退会しているかを判断するメソッド
    def user_state
      # 入力されたemailからアカウントを1件取得
      @user = User.find_by(email: params[:user][:email])
      # アカウントを取得できなかった場合、このメソッドを終了する
      return if !@user
      # 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
      if @user.valid_password?(params[:user][:password]) && @user.is_deleted
        flash[:alert] = "退会済みです。再度ご登録をしてご利用ください。"
        # is_deletedの値がtrueだった場合はサインアップ画面に遷移する処理を実行
        redirect_to new_user_registration_path
      end
    end
end
