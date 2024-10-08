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
  end

  def show
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  
  private
  def review_params
    params.require(:review).permit(:shop, :address, :title, :body, :star, :image)
  end
  
end