class User::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  def mypage
  end

  def edit
  end

  def index
  end

  def show
  end
  
  def update
  end

  def unsubscribe
  end
  
  def withdraw
  end
end