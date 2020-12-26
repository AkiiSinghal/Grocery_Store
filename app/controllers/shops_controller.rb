class ShopsController < ApplicationController
  def index
    if user_signed_in?
      if current_user.admin
        redirect_to admin_index_path
      end
      if current_user.user_type == 'Vendor'
        redirect_to items_path
      end
    end
    
    @shops = User.where("user_type = 'Vendor'").search(params[:search]).all


  end

  def items
    @items = Item.where("user_id = #{params[:user_id]}").all
  end

  def show
    @item = Item.find(params[:id])
  end
end
