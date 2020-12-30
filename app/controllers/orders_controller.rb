class OrdersController < ApplicationController
  before_action :authenticate_user!, except: []
  before_action :correct_user, except: [:update]

  def index
    @orders = Order.where(user_id: current_user.id).all
    if @orders.count == 0
      redirect_to empty_order_path
    end
  end

  def checkout
    userid = current_user.id
    @orders =  CartItem.where("user_id = #{userid}")
    flag = false
    @orders.each do |order|
      if order.quantity > order.available
        flag = true
        break
      end
    end
    if flag
      flash[:notice] = 'Sorry, some products are not available please edit your cart.'
      redirect_to cart_items_path
    else
      @orders.each do |order|
        name = order.name
        description = order.description
        price = order.price
        quantity = order.quantity
        itemid = order.item_id
        status = "Placed"
        Order.create(:name=>name, :description=>description, :price=>price, :quantity=>quantity, :status=>status, :user_id=>userid, :item_id=>itemid)
        order.destroy
        @item = Item.find(itemid)
        quantity = @item.quantity - quantity
        @item.quantity = quantity
        @item.save
        @cartitems =  CartItem.where("item_id = #{itemid}")
        @cartitems.each do |cartitem|
          cartitem.available = quantity
          cartitem.save
        end
      end
    end
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to admin_index_path
    else
      redirect_to orders_path
    end
  end

  def destroy
    @order = Order.find(params[:id])
    itemid = @order.item_id
    quantity = @order.quantity
    @order.destroy
    @item = Item.find(itemid)
    quantity = @item.quantity + quantity
    @item.quantity = quantity
    @item.save
    @cartitems =  CartItem.where("item_id = #{itemid}")
    @cartitems.each do |cartitem|
      cartitem.available = quantity
      cartitem.save
    end
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
