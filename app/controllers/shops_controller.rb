class ShopsController < ApplicationController
  def index
    @shops = User.select("id, shop").where("user_type = 'Vendor'").all
  end

  def items
    @items = Item.where("user_id = #{params[:user_id]}").all
  end

  def show
    @item = Item.find(params[:id])
  end
end
