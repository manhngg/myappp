class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :address
      t.string :email
      t.string :phone
      t.integer :order_status, default: 1
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

