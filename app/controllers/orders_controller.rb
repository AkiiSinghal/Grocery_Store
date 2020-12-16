class OrdersController < ApplicationController
  before_action :authenticate_user!, except: []
  before_action :correct_user, except: [:update]

  def index
    @orders = Order.all
  end

  def checkout
    userid = current_user.id
    @orders =  CartItem.where("user_id = #{userid}")
    @orders.each do |order|
      name = order.name
      description = order.description
      price = order.price
      quantity = order.quantity
      itemid = order.item_id
      status = "Placed"
      Order.create(:name=>name, :description=>description, :price=>price, :quantity=>quantity, :status=>status, :user_id=>userid, :item_id=>itemid)
      order.destroy
    end
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to admin_index_path
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    redirect_to orders_path
  end

  def correct_user
    usertype = current_user.user_type
    unless
      usertype == "Customer" &&
      current_user.admin == false
      redirect_to root_url, notice: "Not Authorized To Access Cart"
    end
  end

  private
    def order_params
      params.require(:order).permit(:name, :description, :price, :quantity, :status, :user_id, :item_id)
    end
end
