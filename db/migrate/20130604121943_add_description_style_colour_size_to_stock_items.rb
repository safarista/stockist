class AddDescriptionStyleColourSizeToStockItems < ActiveRecord::Migration
  def change
    add_column :stock_items, :description, :text
    add_column :stock_items, :style, :string
    add_column :stock_items, :colour_name, :string
    add_column :stock_items, :size_name, :string
  end
end
