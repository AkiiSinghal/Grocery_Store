class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.float :price
      t.integer :quantity
      t.integer :user_id

      t.timestamps
    end
    add_index :items, :user_id
  end
end
