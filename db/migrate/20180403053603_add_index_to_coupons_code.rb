class AddIndexToCouponsCode < ActiveRecord::Migration[5.1]
  def change
    add_index :coupons, :code, unique: true
  end
end
