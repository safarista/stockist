class Branch < ActiveRecord::Base
  attr_accessible :name
  validates_presence_of :name
  has_many :stock_items, dependent: :nullify
end
