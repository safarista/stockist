class CreateStockItems < ActiveRecord::Migration
  def change
    create_table :stock_items do |t|
      t.integer :plu
      t.references :branch
      t.integer :stock_quantity
      t.integer :min_stock_quantity
      t.integer :max_stock_quantity
      t.integer :root_plu
      t.decimal :bsretail_price, precision: 8, scale: 2

      t.timestamps
    end
    add_index :stock_items, :branch_id
  end
end
