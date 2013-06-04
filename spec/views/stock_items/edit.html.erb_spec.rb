require 'spec_helper'

describe "stock_items/edit" do
  before(:each) do
    @stock_item = assign(:stock_item, stub_model(StockItem,
      :plu => "",
      :branch => nil,
      :stock_quantity => 1,
      :min_stock_quantity => 1,
      :max_stock_quantity => 1,
      :root_plu => 1
    ))
  end

  it "renders the edit stock_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", stock_item_path(@stock_item), "post" do
      assert_select "input#stock_item_plu[name=?]", "stock_item[plu]"
      assert_select "input#stock_item_branch[name=?]", "stock_item[branch]"
      assert_select "input#stock_item_stock_quantity[name=?]", "stock_item[stock_quantity]"
      assert_select "input#stock_item_min_stock_quantity[name=?]", "stock_item[min_stock_quantity]"
      assert_select "input#stock_item_max_stock_quantity[name=?]", "stock_item[max_stock_quantity]"
      assert_select "input#stock_item_root_plu[name=?]", "stock_item[root_plu]"
    end
  end
end
