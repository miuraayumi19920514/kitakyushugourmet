class User::ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  def new
    @review = Review.new
  end
  
  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      flash[:notice]="レビュー投稿しました"
      redirect_to mypage_path
    else
      redirect_to request.referer
    end
  end

  def index
    @reviews = Review.all.includes(:user)
  end

  def show
    @review = Review.find(params[:id])
    @user = @review.user
  end
  
  def edit
    @review = Review.find(params[:id])
  end
  
  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      flash[:notice] = "編集しました。"
      redirect_to review_path(@review)
    else
      render:@review
    end
  end
  
  def destroy
    review = Review.find(params[:id])
    review.destroy
    redirect_to mypage_path
  end
  
  
  private
  def review_params
    params.require(:review).permit(:shop, :address, :title, :body, :star, :image)
  end
  
end