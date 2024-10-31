class User::MapsController < ApplicationController
  before_action :redirect_to_signup_unless_logged_in
  def show
  end

  private
  def redirect_to_signup_unless_logged_in#ログインしていなければ、mapを開こうとしたら新規登録画面に遷移する
    unless user_signed_in?
      redirect_to new_user_registration_path
    end
  end


end
