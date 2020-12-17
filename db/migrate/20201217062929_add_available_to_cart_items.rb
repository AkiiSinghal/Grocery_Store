class AddAvailableToCartItems < ActiveRecord::Migration[6.0]
  def change
    add_column :cart_items, :available, :integer
  end
end
