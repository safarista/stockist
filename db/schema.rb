# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130620114933) do

  create_table "branches", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "the_branch"
  end

  create_table "products", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "stock_items", :force => true do |t|
    t.integer  "plu"
    t.integer  "branch_id"
    t.integer  "stock_quantity"
    t.integer  "min_stock_quantity"
    t.integer  "max_stock_quantity"
    t.integer  "root_plu"
    t.decimal  "bsretail_price",     :precision => 8, :scale => 2
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
    t.text     "description"
    t.string   "style"
    t.string   "colour_name"
    t.string   "size_name"
  end

  add_index "stock_items", ["branch_id"], :name => "index_stock_items_on_branch_id"

end
