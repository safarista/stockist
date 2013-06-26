# # -*- encoding : utf-8 -*-

require 'csv'

namespace :csv do

  csv_file = "#{Dir.pwd}/db/seeds/BranchStock-Export.csv"
  entries = CSV.read(csv_file, encoding: "UTF-8")[1...-1]

  desc "Import Store Branches data"
  task :import_branches => :environment do
    puts "Started importing Branches..."
    begin
      branches = entries.map { |b| b[2] }.uniq
      branches.each { |b| Branch.find_or_create_by_name(name: b) }
      puts "CSV Branches data has been successfully imported"
    rescue Exception => e
      puts "Errors were encountered: #{e.class} => #{e.message}"
    end
  end

  desc "Import Branch Stock"
  task :import_branch_stock => :environment do
    begin
      sto_items = entries.map { |si| [ si[0], si[1], si[2], si[3], si[4], si[5], si[6], si[7], si[8], si[9], si[10] ] }.uniq
      sto_items.each do |i|
        b = Branch.find_by_name(i[2])
        if b
          StockItem.find_or_create_by_plu({
            plu: i[1],
            branch_id: b.id,
            stock_quantity: i[4],
            min_stock_quantity: i[5],
            max_stock_quantity: i[6],
            root_plu: i[8],
            bsretail_price: i[9]
          }, without_protection: true)
        end
      end
      puts "CSV BranchStock has been imported successfully"
    rescue Exception => e
      puts "Errors were encountered: #{e.class} => #{e.message}"
    end
  end

# products.map { |p|
#   if StockItem.find_by_plu(p.plu)
#     # UPDATE SQL SCRIPT
#   else
#     # INSERT SQL SCRIPT
#   end
# }

  products_csv = CSV.read("#{Dir.pwd}/db/seeds/Products-Export.csv", encoding: 'windows-1251:utf-8')[1..-1]
  products = products_csv.map { |p| [ p[1], p[2], p[3], p[4], p[7], p[11] ] }.uniq

  desc "Import Products descriptions"
  task :import_product_info => :environment do
#     # begin
#     #   puts "===Starting to seed Products-Export.csv Data into the database==="
#     #   products.each do |p|
#     #     StockItem.find_or_create_by_plu({
#     #       plu: p[1],
#     #       root_plu: p[0],
#     #       branch_id: 1,
#     #       stock_quantity: 0,
#     #       description: p[2],
#     #       style: p[3],
#     #       size_name: p[4],
#     #       colour_name: p[5]
#     #       }, without_protection: true
#     #     )
#     #   end
#     #   puts "Finished: CSV 'Products-Export' Data has been Added"
#     # rescue Exception => e
#     #   puts "Errors were encountered: #{e.class} => #{e.message}"
#     # end

    begin
      products.each do |p|
        StockItem.where('root_plu = ?', p[0]).find_in_batches do |batch|
          # sleep 2
          batch.each do |product|
            if product.plu == p[1].to_i
              product.update_attributes({
                description: p[2],
                min_stock_quantity: 0,
                style: p[3],
                size_name: p[4],
                colour_name: p[5]}, without_protection: true
              )
            end
          end
        end
      end
    puts "CSV 'Products-Export' Data has been updated"
    rescue Exception => e
      puts "Errors were encountered: #{e.class} => #{e.message}"
    end

  end

  desc "Create or update stock_items"
  task :crate_or_update_stock => :environment do

    # Find a stock_item
    # if it exists and update its min_stock_quantity = 0
    # if not create it
    branches = Branch.all
    begin
      puts 'Importing products has started'

      for branch in branches do
        products.each do |p|
        StockItem.find_or_initialize_by_branch_id_and_root_plu_and_plu(
          branch.id,
          p[0],
          p[1]
          ).tap do |si|
            si.description = p[2],
            si.colour_name = p[5],
            si.style = p[3],
            si.size_name = p[4]
            # ,
            # si.stock_quantity = 0,
            # si.min_stock_quantity = 0
          end.save!
        end
      end
      puts 'Importing products has completed successfully'
    rescue Exception => e
      puts "Errors were encountered: #{e.class} => #{e.message}"
    end
  end

  # desc "Update stock_quantity and min_stock_quantity"
  # task :update_qty_and_min_qty => :environment do
  #   begin
  #     StockItem.find_each do |record|
  #       if record.stock_quantity.nil?
  #         record.update_attribute(:stock_quantity, 0)
  #       end
  #       if record.min_stock_quantity.nil?
  #         record.update_attribute(:min_stock_quantity, 0)
  #       end
  #     end
  #   rescue Exception => e
  #     puts "Errors were encountered: #{e.class} => #{e.message}"
  #   end
  # end

end

