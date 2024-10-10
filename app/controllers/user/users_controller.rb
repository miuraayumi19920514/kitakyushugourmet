class User::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
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
    flash[:notice] = "退会しました"
    redirect_to root_path
  end
  
  private
  def user_params
    params.require(:user).permit(:image, :name, :introduction )
  end
  
end