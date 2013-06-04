require "spec_helper"

describe StockItemsController do
  describe "routing" do

    it "routes to #index" do
      get("/stock_items").should route_to("stock_items#index")
    end

    it "routes to #new" do
      get("/stock_items/new").should route_to("stock_items#new")
    end

    it "routes to #show" do
      get("/stock_items/1").should route_to("stock_items#show", :id => "1")
    end

    it "routes to #edit" do
      get("/stock_items/1/edit").should route_to("stock_items#edit", :id => "1")
    end

    it "routes to #create" do
      post("/stock_items").should route_to("stock_items#create")
    end

    it "routes to #update" do
      put("/stock_items/1").should route_to("stock_items#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/stock_items/1").should route_to("stock_items#destroy", :id => "1")
    end

  end
end
