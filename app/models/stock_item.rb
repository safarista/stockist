class StockItem < ActiveRecord::Base
  belongs_to :branch
  attr_accessible :max_stock_quantity, :bsretail_price, :min_stock_quantity, :plu, :root_plu, :stock_quantity, :branch_id
  validates_presence_of :plu, :branch, :stock_quantity, :min_stock_quantity, :max_stock_quantity

  def self.search(search)
    if search
      where('plu LIKE ? OR root_plu LIKE ?', "#{search}", "#{search}")
    else
      scoped
    end
  end
end
