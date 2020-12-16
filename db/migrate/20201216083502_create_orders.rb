class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :name
      t.text :description
      t.float :price
      t.integer :quantity
      t.string :status
      t.integer :user_id
      t.integer :item_id

      t.timestamps
    end
    add_index :orders, :user_id
  end
end
