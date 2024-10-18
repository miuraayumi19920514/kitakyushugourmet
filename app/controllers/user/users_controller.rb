class User::UsersController < ApplicationController
  before_action :redirect_to_signup_unless_logged_in, except: [:index, :show]
  
  def mypage
    @user = current_user
    if params[:latest]
      @reviews = @user.reviews.latest
    elsif params[:old]
      @reviews = @user.reviews.old
    elsif params[:favorite_count]
      @reviews = @user.reviews.includes(:favorites).sort {|a,b| b.favorites.size <=> a.favorites.size}
    else
      @reviews = @user.reviews.order(created_at: :desc)
    end
  end

  def index
    @users = User.where(is_active: true).all#退会した人を非表示にしている
  end

  def show
    @user = User.find(params[:id])
    if params[:latest]
      @reviews = @user.reviews.latest
    elsif params[:old]
      @reviews = @user.reviews.old
    elsif params[:favorite_count]
      @reviews = @user.reviews.includes(:favorites).sort {|a,b| b.favorites.size <=> a.favorites.size}
    else
      @reviews = @user.reviews.order(created_at: :desc)
    end
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to mypage_path(@user)
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