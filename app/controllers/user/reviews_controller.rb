class User::ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :is_matching_login_user, only: [:edit, :update]

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
      render :new
    end
  end

  def index
    @reviews = Review.all.includes(:user)
  end

  def show
    @review = Review.find(params[:id])
    @user = @review.user
    @comment = Comment.new
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
  
  def is_matching_login_user#レビューがログインユーザーのレビューではなかったらマイページに戻る
    review = Review.find_by(id: params[:id])
    if review.nil? || review.user != current_user
      redirect_to mypage_path, alert: "権限がありません"
    end
  end
    
  

end


