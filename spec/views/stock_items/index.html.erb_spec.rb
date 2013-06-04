require 'spec_helper'

describe "stock_items/index" do
  before(:each) do
    assign(:stock_items, [
      stub_model(StockItem,
        :plu => "",
        :branch => nil,
        :stock_quantity => 1,
        :min_stock_quantity => 2,
        :max_stock_quantity => 3,
        :root_plu => 4
      ),
      stub_model(StockItem,
        :plu => "",
        :branch => nil,
        :stock_quantity => 1,
        :min_stock_quantity => 2,
        :max_stock_quantity => 3,
        :root_plu => 4
      )
    ])
  end

  it "renders a list of stock_items" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
