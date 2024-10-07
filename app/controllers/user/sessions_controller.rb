# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController
  before_action :user_state, only: [:create]

   def after_sign_in_path_for(resource)
     root_path
   end
  
  private

    def user_state
        user = User.find_by(email: params[:user][:email])
        if user.nil?
          flash[:alert] = "アカウントが見つかりません。新規会員登録を行ってください。"
          redirect_to new_user_registration_path and return
        end
        
        unless user.valid_password?(params[:user][:password])
          flash[:alert] = "メールアドレス or パスワードが違います。"
          redirect_to new_user_session_path and return
        end
        
        if user.is_active == false
          flash[:alert] = "退会済みです。新規会員登録を行ってください"
          redirect_to new_user_registration_path
        end
    end
  
  
  
  # before_action :configure_sign_in_params, only: [:create]

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
end
