class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    if params[:latest]
      @comments = Comment.latest.page(params[:page]).per(10)
    elsif params[:old]
      @comments = Comment.old.page(params[:page]).per(10)
    else
      @comments = Comment.all.page(params[:page]).per(10)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @review = @comment.review
    @comments = Comment.all.page(params[:page]).per(10)
    @comment.destroy
  end
end
