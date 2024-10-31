class User::ReviewsController < ApplicationController
  before_action :redirect_to_signup_unless_logged_in, except: [:index, :show]
  before_action :is_matching_login_user, only: [:edit, :update]

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to review_path(@review)
    else
      render :new
    end
  end

# ソート機能とフィルター機能と検索機能の条件に合わせて分岐させている
  def index
    @reviews = Review.includes(:user).where(users: { is_active: true }).latest.page(params[:page]).per(10)
    sort = params[:sort]
    @local_person = params[:local_person]
      if sort
        if params[:latest]
          if @local_person == ""
            @reviews = Review.includes(:user).where(users: { is_active: true }).latest.page(params[:page]).per(10)
          elsif @local_person
            @reviews = Review.includes(:user).where(users: {local_person: @local_person, is_active: true}).latest.page(params[:page]).per(10)
          else
            @reviews = Review.includes(:user).where(users: { is_active: true }).latest.page(params[:page]).per(10)
          end
        elsif params[:old]
          if @local_person == ""
            @reviews = Review.includes(:user).where(users: { is_active: true }).old.page(params[:page]).per(10)
          elsif @local_person
            @reviews = Review.includes(:user).where(users: {local_person: @local_person, is_active: true}).old.page(params[:page]).per(10)
          else
            @reviews = Review.includes(:user).where(users: { is_active: true }).old.page(params[:page]).per(10)
          end
        elsif params[:favorite_count]
          if @local_person == ""
            sorted_reviews = Review.includes(:favorites, :user).where(users: { is_active: true }).sort {|a,b| b.favorites.size <=> a.favorites.size}
            @reviews = Kaminari.paginate_array(sorted_reviews).page(params[:page]).per(10)
          elsif @local_person
            @reviews = Review.includes(:user).where(users: { local_person: @local_person, is_active: true }).page(params[:page]).per(10)
            sorted_reviews = Review.includes(:favorites, :user).where(users: { local_person: @local_person, is_active: true }).sort {|a,b| b.favorites.size <=> a.favorites.size}
            @reviews = Kaminari.paginate_array(sorted_reviews).page(params[:page]).per(10)
          else
            sorted_reviews = Review.includes(:favorites, :user).where(users: { is_active: true }).sort {|a,b| b.favorites.size <=> a.favorites.size}
            @reviews = Kaminari.paginate_array(sorted_reviews).page(params[:page]).per(10)
          end
        else
          @reviews = Review.all.includes(:user).where(users: { is_active: true }).order(created_at: :desc).page(params[:page]).per(10)
          #退会した人のレビューを非表示にしている
        end
      elsif @local_person
        if @local_person == 'local'
          @reviews = Review.includes(:user).where(users: {local_person:1, is_active: true}).page(params[:page]).per(10)
        elsif @local_person == 'traveler'
          @reviews = Review.includes(:user).where(users: {local_person:0, is_active: true}).page(params[:page]).per(10)
        else
          @reviews = Review.includes(:user).where(users: { is_active: true }).page(params[:page]).per(10)
        end
      end
  end

  def show
    @review = Review.find(params[:id])
    @user = @review.user
    @comment = Comment.new
    @comments = @review.comments.page(params[:page]).per(10)
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    @review.update(image: nil) if review_params[:image] == nil
    if @review.update(review_params)
      redirect_to mypage_path
    else
      render :edit
    end
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    redirect_to mypage_path
  end

  private
  def review_params
    params.require(:review).permit(:shop, :address, :genre, :title, :body, :star, :image)
  end

  def is_matching_login_user#レビューがログインユーザーのレビューではなかったらマイページに戻る
    review = Review.find_by(id: params[:id])
    if review.nil? || review.user != current_user
      redirect_to mypage_path
    end
  end

  def redirect_to_signup_unless_logged_in#ログインしていなければ、reviewしようとしたら新規登録画面に遷移する
    unless user_signed_in?
      redirect_to new_user_registration_path
    end
  end



end


