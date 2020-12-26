class AddExtraFieldsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name, :string, null: false, default: ""
    add_column :users, :last_name, :string, null: false, default: ""
    add_column :users, :address, :text
    add_column :users, :phone, :string
    add_column :users, :user_type, :string
    add_column :users, :shop, :string
    add_column :users, :admin, :boolean, default: false
  end
end
