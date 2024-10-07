class User::ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  def new
  end
  
  def create
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
end