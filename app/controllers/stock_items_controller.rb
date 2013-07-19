require "find"

class StockItemsController < ApplicationController
  # GET /stock_items
  # GET /stock_items.json
  def index
    @stock_items = StockItem.search(params[:search]).order('stock_items.plu ASC').paginate(page: params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stock_items }
    end
  end

  # GET /stock_items/1
  # GET /stock_items/1.json
  def show
    @stock_item = StockItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stock_item }
    end
  end

  # GET /stock_items/new
  # GET /stock_items/new.json
  def new
    @stock_item = StockItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stock_item }
    end
  end

  # GET /stock_items/1/edit
  def edit
    @stock_item = StockItem.find(params[:id])
  end

  # POST /stock_items
  # POST /stock_items.json
  def create
    @stock_item = StockItem.new(params[:stock_item])

    respond_to do |format|
      if @stock_item.save
        format.html { redirect_to @stock_item, notice: 'Stock item was successfully created.' }
        format.json { render json: @stock_item, status: :created, location: @stock_item }
      else
        format.html { render action: "new" }
        format.json { render json: @stock_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stock_items/1
  # PUT /stock_items/1.json
  def update
    @stock_item = StockItem.find(params[:id])

    respond_to do |format|
      if @stock_item.update_attributes(params[:stock_item])
        format.html { redirect_to @stock_item, notice: 'Stock item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stock_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stock_items/1
  # DELETE /stock_items/1.json
  def destroy
    @stock_item = StockItem.find(params[:id])
    @stock_item.destroy

    respond_to do |format|
      format.html { redirect_to stock_items_url }
      format.json { head :no_content }
    end
  end

  def rename_file
    branch = Branch.find(params[:branch_id]).name.to_s.downcase.gsub(/[^a-z]/, '_')
    old_file = File.join("#{Dir.pwd}/public/", "#{branch}.sql")

    if File.exists?(old_file)
      File.rename(old_file, old_file + "-#{Time.now.strftime('%Y%m%d%H%M%S')}.sql")
      redirect_to :back, notice: "File has been saved as with a timestamp. Download the file."
    else
      flash[:error] = "No such file was found :(. Try updating some records."
      redirect_to :back
    end
  end

  def update_individual
    # binding.pry
    items = params[:stock_items].keys.map { |i| i.to_i }
    @stock_items = StockItem.update(params[:stock_items].keys, params[:stock_items].values).reject { |p| p.errors.empty? }

  StockItem.find( items ).each do |item|
    filoname = item.branch.name.to_s.downcase.gsub(/[^a-z]/, '_')

    File.open("#{Dir.pwd}/public/#{filoname}.sql", "a") do |f|
        pluo = item.plu.to_s.rjust(10, "0")
        rootplu = item.root_plu.to_s.rjust(8, "0")
        item_values = [ pluo, "#{item.branch.name}", item.branch.the_branch, item.stock_quantity ? item.stock_quantity : 0, item.min_stock_quantity ? item.min_stock_quantity : 0, 0, 0, rootplu, 0.0 ]

        if item.created_at <= Time.parse('2013-07-19 11:55:25') && item.updated_at + 30.seconds > Time.now
          f.write %Q{UPDATE branchstock
SET branchstock.STOCK_QUANTITY=#{item.stock_quantity}, branchstock.MIN_STOCK_QUANTITY=#{item.min_stock_quantity}
FROM branchstock
WHERE branchstock.BRANCH_NAME='#{item.branch.name}' AND branchstock.PLU='#{pluo}' AND branchstock.ROOT_PLU='#{rootplu}';\n\n}
        elsif item.created_at > Time.parse('2013-07-19 11:55:25') && item.updated_at + 30.seconds > Time.now
          q = %Q{INSERT INTO 'branchstock' (PLU,BRANCH_NAME,BRANCH_ID,STOCK_QUANTITY,MIN_STOCK_QUANTITY,MAX_STOCK_QUANTITY,BARCODES_QUANTITY,ROOT_PLU,BSRETAIL_PRICE)
VALUES(#{item_values});\n\n}.gsub(/(\[|\])/m, '')
          f.write q
        end

        # f.write  "UPDATE branchstock SET branchstock.STOCK_QUANTITY=#{item.stock_quantity}, branchstock.MIN_STOCK_QUANTITY=#{item.min_stock_quantity} FROM branchstock WHERE branchstock.BRANCH_NAME='#{item.branch.name}' AND branchstock.PLU='#{item.plu}';\n" if item.updated_at + 30.seconds > Time.now
      end
    end
    if @stock_items.empty?
      flash[:notice] = "Products updated. "
      redirect_to :back
    else
      flash[:notice] = "There were errors: #{e.class} => #{e.message}"
      render :action => "edit_individual"
    end

    # @stock_items = StockItem.update(params[:stock_items].keys, params[:stock_items].values).reject { |p| p.errors.empty? }
    # branch = Branch.find(:first, params[:id])
  end

end