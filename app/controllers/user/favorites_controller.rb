class User::FavoritesController < ApplicationController
  before_action :redirect_to_signup_unless_logged_in
  
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

  
  private
  
  def redirect_to_signup_unless_logged_in#ログインしていなければfavorite系のボタンを押したときに新規登録画面に遷移する
    unless user_signed_in?
      redirect_to new_user_registration_path
    end
  end
  
end