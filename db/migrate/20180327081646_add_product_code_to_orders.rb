class AddProductCodeToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :product_code, :string
  end
end
