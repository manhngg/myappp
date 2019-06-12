class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.bigint :user_id
      t.references :product, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end
