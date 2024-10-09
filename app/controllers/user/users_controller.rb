class User::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  def mypage
    @user = current_user
    @reviews = @user.reviews
  end

  def index
    @users = User.all
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
  end
  
  def withdraw
  end
  
  private
  def user_params
    params.require(:user).permit(:image, :name, :introduction )
  end
  
end