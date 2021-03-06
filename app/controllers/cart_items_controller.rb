class CartItemsController < ApplicationController
  before_action :authenticate_user!, except: []
  before_action :correct_user, except: []

  def index
    @items = CartItem.where(:user_id => current_user.id).all
    if @items.count == 0
      redirect_to empty_cart_item_path
    end
  end

  def empty
  end

  def add
    @item = Item.find(params[:id])
    itemid = @item.id
    itemuserid = @item.user_id
    userid = current_user.id
    price = @item.price
    @cart_item = CartItem.where("user_id = #{userid} and item_id = #{itemid}")
    if @cart_item.count == 0
      available = @item.quantity
      name = @item.name
      description = @item.description
      quantity = 1
      CartItem.create(:name=>name, :description=>description, :price=>price, :quantity=>quantity, :user_id=>userid, :item_id=>itemid, :available=>available)
    else
      @cart_item = @cart_item.first
      @cart_item.quantity += 1
      @cart_item.price += price
      @cart_item.save
    end
    redirect_to "/shops/#{itemuserid}/#{itemid}"
  end

  def buy
    @item = Item.find(params[:id])
    itemid = @item.id
    userid = current_user.id
    price = @item.price
    @cart_item = CartItem.where("user_id = #{userid} and item_id = #{itemid}")
    if @cart_item.count == 0
      available = @item.quantity
      name = @item.name
      description = @item.description
      quantity = 1
      CartItem.create(:name=>name, :description=>description, :price=>price, :quantity=>quantity, :user_id=>userid, :item_id=>itemid, :available=>available)
    else
      @cart_item = @cart_item.first
      @cart_item.quantity += 1
      @cart_item.price += price
      @cart_item.save
    end
    redirect_to cart_items_path
  end

  def update
    @item = CartItem.find(params[:id])
    updateditems = item_params
    if updateditems["quantity"].to_i < 1
      redirect_to cart_items_path, notice: "Quantity should be greater than or eqaul to 1."
    else
      price = @item.price / @item.quantity
      updateditems["price"] = price * updateditems["quantity"].to_i
      if @item.update(updateditems)
        redirect_to cart_items_path
      else
        redirect_to cart_items_path
      end
    end
  end

  def destroy
    @item = CartItem.find(params[:id])
    @item.destroy

    redirect_to cart_items_path
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
    def item_params
      params.require(:cart_item).permit(:name, :description, :price, :quantity, :user_id, :item_id)
    end

end
