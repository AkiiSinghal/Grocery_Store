class CreateCartItems < ActiveRecord::Migration[6.0]
  def change
    create_table :cart_items do |t|
      t.string :name
      t.text :description
      t.float :price
      t.integer :quantity
      t.integer :user_id
      t.integer :item_id

      t.timestamps
    end
    add_index :cart_items, :user_id
  end
end
