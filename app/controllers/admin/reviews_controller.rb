class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!
  
  def show
    @review = Review.find(params[:id])
    @user = @review.user
  end

  def index
    @reviews = Review.latest.page(params[:page]).per(10)
    sort = params[:sort]
    @local_person = params[:local_person]
      if sort
        if params[:latest]
          if @local_person == ""
            @reviews = Review.latest.page(params[:page]).per(10)
          elsif @local_person
            @reviews = Review.includes(:user).where(users: {local_person: @local_person}).latest.page(params[:page]).per(10)
          else
            @reviews = Review.latest.page(params[:page]).per(10)
          end
        elsif params[:old]
          if @local_person == ""
            @reviews = Review.old.page(params[:page]).per(10)
          elsif @local_person
            @reviews = Review.includes(:user).where(users: {local_person: @local_person}).old.page(params[:page]).per(10)
          else
            @reviews = Review.old.page(params[:page]).per(10)
          end
        elsif params[:favorite_count]
          if @local_person == ""
            sorted_reviews = Review.includes(:favorites).sort {|a,b| b.favorites.size <=> a.favorites.size}
            @reviews = Kaminari.paginate_array(sorted_reviews).page(params[:page]).per(10)
          elsif @local_person
            @reviews = Review.includes(:user).where(users: {local_person: @local_person}).page(params[:page]).per(10)
            sorted_reviews = Review.includes(:favorites, :user).where(users: {local_person: @local_person}).sort {|a,b| b.favorites.size <=> a.favorites.size}
            @reviews = Kaminari.paginate_array(sorted_reviews).page(params[:page]).per(10)
          else
            sorted_reviews = Review.includes(:favorites).sort {|a,b| b.favorites.size <=> a.favorites.size}
            @reviews = Kaminari.paginate_array(sorted_reviews).page(params[:page]).per(10)
          end
        else
          @reviews = Review.all.includes(:user).where(users: { is_active: true }).order(created_at: :desc).page(params[:page]).per(10)
          #退会した人のレビューを非表示にしている
        end
      elsif @local_person
        if @local_person == 'local'
          @reviews = Review.includes(:user).where(users: {local_person:1}).page(params[:page]).per(10)
        elsif @local_person == 'traveler'
          @reviews = Review.includes(:user).where(users: {local_person:0}).page(params[:page]).per(10)
        else
          @reviews = Review.all.page(params[:page]).per(10)
        end
      end
  end

  def edit
    @review = Review.find(params[:id])
  end
  
  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to admin_review_path(@review)
    else
      render :edit
    end
  end
  
  def destroy
    review = Review.find(params[:id])
    review.destroy
    redirect_to admin_reviews_path
  end
  
  private
  def review_params
    params.require(:review).permit(:shop, :address, :genre, :title, :body, :star, :image)
  end
  
end
