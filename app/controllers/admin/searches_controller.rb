class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search
    @word = params[:word]
    @range = params[:range]
    sort = params[:sort]
    @local_person = params[:local_person]
  
    if @range == 'レビュー'
      # 検索条件を共通化
      @reviews = Review.includes(:user).where(users: { is_active: true }).where('title LIKE :keyword OR genre LIKE :keyword OR body LIKE :keyword OR shop LIKE :keyword OR address LIKE :keyword', keyword: "%#{@word}%")
  
      # local_personに基づくフィルタリング
      if @local_person.present?
        @reviews = @reviews.includes(:user).where(users: { local_person: @local_person })
      end
  
      # ソート処理
      if sort
        if params[:latest]
          @reviews = @reviews.latest
        elsif params[:old]
          @reviews = @reviews.old
        elsif params[:favorite_count]
          sorted_reviews = @reviews.includes(:favorites).sort_by { |review| -review.favorites.size }
          @reviews = Kaminari.paginate_array(sorted_reviews).page(params[:page]).per(10)
        end
      end
  
      # ページネーション
      @reviews = @reviews.page(params[:page]).per(10)
  
    elsif @range == 'ユーザー'
      @users = User.where('name LIKE :keyword', keyword: "%#{@word}%")
  
      if @local_person.present?
        @users = @users.where(local_person: @local_person == 'local' ? 1 : 0)
      else
        @users = @users.where(is_active: true)
      end
  
      @users = @users.page(params[:page]).per(10)
    end
  end
end