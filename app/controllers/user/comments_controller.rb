class User::CommentsController < ApplicationController
  before_action :redirect_to_signup_unless_logged_in

  def create
    @review = Review.find(params[:review_id])
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    comment.review_id = @review.id
    comment.save
  end

  def destroy
    @review = Review.find(params[:review_id])
    @comment = @review.comments.find(params[:id])
    @comment.destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
  
  def redirect_to_signup_unless_logged_in#ログインしていなければコメントボタンを押したときに新規登録画面に遷移する
    unless user_signed_in?
      redirect_to new_user_registration_path
    end
  end

end