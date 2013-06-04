require 'spec_helper'

describe "stock_items/show" do
  before(:each) do
    @stock_item = assign(:stock_item, stub_model(StockItem,
      :plu => "",
      :branch => nil,
      :stock_quantity => 1,
      :min_stock_quantity => 2,
      :max_stock_quantity => 3,
      :root_plu => 4
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
  end
end
