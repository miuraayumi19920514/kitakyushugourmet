class User::UsersController < ApplicationController
  before_action :redirect_to_signup_unless_logged_in, except: [:index, :show]
  
  def mypage
    @user = current_user
    @reviews = @user.reviews
  end

  def index
    @users = User.all#退会した人を非表示にするにはここに何かを書く
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "編集しました。"
      redirect_to mypage_path
    else
      render :edit
    end
  end

  def unsubscribe
    @user = current_user
  end
  
  def withdraw
    @user = current_user
    @user.update(is_active: false)
    reset_session
    redirect_to completion_path
  end
  
  def completion
    
  end
  
  private
  def user_params
    params.require(:user).permit(:image, :name, :introduction )
  end
  
  def redirect_to_signup_unless_logged_in#ログインしていなければ、mypageやeditに飛ぼうとしたら新規登録画面に遷移する
    unless user_signed_in?
      redirect_to new_user_registration_path
    end
  end
  
end