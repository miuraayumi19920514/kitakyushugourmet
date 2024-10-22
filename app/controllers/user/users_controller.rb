class User::UsersController < ApplicationController
  before_action :redirect_to_signup_unless_logged_in, except: [:index, :show, :completion]

  def mypage
    @user = current_user
    if params[:latest]
      @reviews = @user.reviews.latest.page(params[:page]).per(10)
    elsif params[:old]
      @reviews = @user.reviews.old.page(params[:page]).per(10)
    elsif params[:favorite_count]
      sorted_reviews = @user.reviews.includes(:favorites).sort {|a,b| b.favorites.size <=> a.favorites.size}
      @reviews = Kaminari.paginate_array(sorted_reviews).page(params[:page]).per(10)
    else
      @reviews = @user.reviews.order(created_at: :desc).page(params[:page]).per(10)
    end
  end

  def index
    @users = User.where(is_active: true).all.page(params[:page]).per(10)
    local_person = params[:local_person]
      if local_person == 'local'
        @users = User.where(local_person:1, is_active: true).page(params[:page]).per(10)
      elsif local_person == 'traveler'
        @users = User.where(local_person:0, is_active: true).page(params[:page]).per(10)
      else
        @users = User.where(is_active: true).all.page(params[:page]).per(10)
        #退会した人を非表示にしている
      end
  end

  def show
    @user = User.find(params[:id])
    if params[:latest]
      @reviews = @user.reviews.latest.page(params[:page]).per(10)
    elsif params[:old]
      @reviews = @user.reviews.old.page(params[:page]).per(10)
    elsif params[:favorite_count]
      sorted_reviews = @user.reviews.includes(:favorites).sort {|a,b| b.favorites.size <=> a.favorites.size}
      @reviews = Kaminari.paginate_array(sorted_reviews).page(params[:page]).per(10)
    else
      @reviews = @user.reviews.order(created_at: :desc).page(params[:page]).per(10)
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