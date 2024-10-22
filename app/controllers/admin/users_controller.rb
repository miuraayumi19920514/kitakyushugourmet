class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  
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

  def index
    @users = User.all.page(params[:page]).per(10)
    local_person = params[:local_person]
      if local_person == 'local'
        @users = User.where(local_person: 1).page(params[:page]).per(10)
      elsif local_person == 'traveler'
        @users = User.where(local_person: 0).page(params[:page]).per(10)
      else
        @users = User.all.page(params[:page]).per(10)
      end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end
  
  def withdrawal
    @user = User.find(params[:id])
    @user.update(is_active: !@user.is_active)
    redirect_to admin_users_path
  end
  
  private
  def user_params
    params.require(:user).permit(:image, :name, :introduction )
  end
  
end
