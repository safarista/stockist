require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe StockItemsController do

  # This should return the minimal set of attributes required to create a valid
  # StockItem. As you add validations to StockItem, be sure to
  # adjust the attributes here as well.
  let(:branch) { find_or_create_by_name(name: 'Lincoln') }
  let(:valid_attributes) { { plu: 101, branch: branch, stock_quantity: 5, min_stock_quantity: 5, max_stock_quantity: 100, root_plu: 1 } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # StockItemsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all stock_items as @stock_items" do
      stock_item = StockItem.create! valid_attributes
      get :index, {}, valid_session
      assigns(:stock_items).should eq([stock_item])
    end
  end

  describe "GET show" do
    it "assigns the requested stock_item as @stock_item" do
      stock_item = StockItem.create! valid_attributes
      get :show, {:id => stock_item.to_param}, valid_session
      assigns(:stock_item).should eq(stock_item)
    end
  end

  describe "GET new" do
    it "assigns a new stock_item as @stock_item" do
      get :new, {}, valid_session
      assigns(:stock_item).should be_a_new(StockItem)
    end
  end

  describe "GET edit" do
    it "assigns the requested stock_item as @stock_item" do
      stock_item = StockItem.create! valid_attributes
      get :edit, {:id => stock_item.to_param}, valid_session
      assigns(:stock_item).should eq(stock_item)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new StockItem" do
        expect {
          post :create, {:stock_item => valid_attributes}, valid_session
        }.to change(StockItem, :count).by(1)
      end

      it "assigns a newly created stock_item as @stock_item" do
        post :create, {:stock_item => valid_attributes}, valid_session
        assigns(:stock_item).should be_a(StockItem)
        assigns(:stock_item).should be_persisted
      end

      it "redirects to the created stock_item" do
        post :create, {:stock_item => valid_attributes}, valid_session
        response.should redirect_to(StockItem.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved stock_item as @stock_item" do
        # Trigger the behavior that occurs when invalid params are submitted
        StockItem.any_instance.stub(:save).and_return(false)
        post :create, {:stock_item => { "plu" => "invalid value" }}, valid_session
        assigns(:stock_item).should be_a_new(StockItem)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        StockItem.any_instance.stub(:save).and_return(false)
        post :create, {:stock_item => { "plu" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested stock_item" do
        stock_item = StockItem.create! valid_attributes
        # Assuming there are no other stock_items in the database, this
        # specifies that the StockItem created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        StockItem.any_instance.should_receive(:update_attributes).with({ "plu" => "" })
        put :update, {:id => stock_item.to_param, :stock_item => { "plu" => "" }}, valid_session
      end

      it "assigns the requested stock_item as @stock_item" do
        stock_item = StockItem.create! valid_attributes
        put :update, {:id => stock_item.to_param, :stock_item => valid_attributes}, valid_session
        assigns(:stock_item).should eq(stock_item)
      end

      it "redirects to the stock_item" do
        stock_item = StockItem.create! valid_attributes
        put :update, {:id => stock_item.to_param, :stock_item => valid_attributes}, valid_session
        response.should redirect_to(stock_item)
      end
    end

    describe "with invalid params" do
      it "assigns the stock_item as @stock_item" do
        stock_item = StockItem.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        StockItem.any_instance.stub(:save).and_return(false)
        put :update, {:id => stock_item.to_param, :stock_item => { "plu" => "invalid value" }}, valid_session
        assigns(:stock_item).should eq(stock_item)
      end

      it "re-renders the 'edit' template" do
        stock_item = StockItem.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        StockItem.any_instance.stub(:save).and_return(false)
        put :update, {:id => stock_item.to_param, :stock_item => { "plu" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested stock_item" do
      stock_item = StockItem.create! valid_attributes
      expect {
        delete :destroy, {:id => stock_item.to_param}, valid_session
      }.to change(StockItem, :count).by(-1)
    end

    it "redirects to the stock_items list" do
      stock_item = StockItem.create! valid_attributes
      delete :destroy, {:id => stock_item.to_param}, valid_session
      response.should redirect_to(stock_items_url)
    end
  end

end
