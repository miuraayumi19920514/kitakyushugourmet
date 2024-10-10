class User::FavoritesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @favorites = Favorite.where(user: params[:user_id]) # 特定のユーザーのいいね一覧を取得
    @user = User.find(params[:user_id]) # userを特定するための変数
  end
  
  def create
    @review = Review.find(params[:review_id])
    @favorite = current_user.favorites.new(review_id: @review.id)
    @favorite.save
  end

  def destroy
    @review = Review.find(params[:review_id])
    @favorite = current_user.favorites.find_by(review_id: @review.id)
    @favorite.destroy
  end

  
end