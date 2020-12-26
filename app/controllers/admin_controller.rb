class AdminController < ApplicationController
  before_action :authenticate_user!, except: []
  before_action :correct_user, except: []

  def index
    @orders = Order.all
  end

  def correct_user
    unless
      current_user.admin == true
      redirect_to root_url, notice: "Not Authorized To Access Cart"
    end
  end
end
