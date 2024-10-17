class User::SearchesController < ApplicationController
  before_action :redirect_to_signup_unless_logged_in

  def search
    @word = params[:word]
    @range = params[:range]

    if @range == 'レビュー'
      @reviews = Review.where('title LIKE :keyword OR genre LIKE :keyword OR body LIKE :keyword OR shop LIKE :keyword OR address LIKE :keyword', keyword: "%#{@word}%").order(created_at: :desc)

    elsif @range == 'ユーザー'
      @users = User.where('name LIKE :keyword', keyword: "%#{@word}%")

    end
  end


  def redirect_to_signup_unless_logged_in#ログインしていなければ、検索しようとしたら新規登録画面に遷移する
    unless user_signed_in?
      redirect_to new_user_registration_path
    end
  end

end

