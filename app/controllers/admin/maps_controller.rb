class Admin::MapsController < ApplicationController
  before_action :authenticate_admin!
  def show
  end
end
