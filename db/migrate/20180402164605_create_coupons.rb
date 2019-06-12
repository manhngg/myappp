class CreateCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :coupons do |t|
      t.string :code
      t.integer :percent
      t.datetime :expire
      t.integer :import
      t.integer :imported, default: 0

      t.timestamps
    end
  end
end
