require 'spec_helper'

describe "stock_items/new" do
  before(:each) do
    assign(:stock_item, stub_model(StockItem,
      :plu => "",
      :branch => nil,
      :stock_quantity => 1,
      :min_stock_quantity => 1,
      :max_stock_quantity => 1,
      :root_plu => 1
    ).as_new_record)
  end

  it "renders new stock_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", stock_items_path, "post" do
      assert_select "input#stock_item_plu[name=?]", "stock_item[plu]"
      assert_select "input#stock_item_branch[name=?]", "stock_item[branch]"
      assert_select "input#stock_item_stock_quantity[name=?]", "stock_item[stock_quantity]"
      assert_select "input#stock_item_min_stock_quantity[name=?]", "stock_item[min_stock_quantity]"
      assert_select "input#stock_item_max_stock_quantity[name=?]", "stock_item[max_stock_quantity]"
      assert_select "input#stock_item_root_plu[name=?]", "stock_item[root_plu]"
    end
  end
end
