# # -*- encoding : utf-8 -*-

# require 'csv'

# namespace :csv do
#   csv_file = "#{Dir.pwd}/db/seeds/BranchStock-Export.csv"
#   entries = CSV.read(csv_file, encoding: "UTF-8")[1...-1]

#   desc "Import Branches data"
#   puts "Started importing Branches..."
#   task :import_branches => :environment do
#     begin
#       branches = entries.map { |b| b[2] }.uniq
#       branches.each { |b| Branch.find_or_create_by_name(name: b) }
#       puts "CSV Branches info has been Added"
#     rescue Exception => e
#       puts "Errors were encountered: #{e.class} => #{e.message}"
#     end
#   end

#   desc "Import Branch Stock"
#   task :import_branch_stock => :environment do
#     begin
#       stock_items = entries.map { |si| [ si[0], si[1], si[2], si[3], si[4], si[5], si[6], si[7], si[8], si[9], si[10] ] }.uniq
#       stock_items.each do |i|
#         Branch.find_by_name(i[2]).
#         stock_items.create({
#           plu: i[1],
#           stock_quantity: i[4],
#           min_stock_quantity: i[5],
#           max_stock_quantity: i[6],
#           root_plu: i[8],
#           bsretail_price: i[9]
#         })
#       end
#       puts "CSV Branches info has been Added"
#     rescue Exception => e
#       puts "Errors were encountered: #{e.class} => #{e.message}"
#     end
#   end

#   desc "Import Products descriptions"
#   task :import_product_info => :environment do
#     products_csv = CSV.read("#{Dir.pwd}/db/seeds/Products-Export.csv", encoding: 'windows-1251:utf-8')[1..-1]
#     products = products_csv.map { |p| [ p[1], p[2], p[3], p[4], p[7], p[11] ] }.uniq

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

#     begin
#       products.each do |p|
#         StockItem.where('root_plu = ?', p[0]).find_in_batches do |batch|
#           # sleep 2
#           batch.each do |product|
#             if product.plu == p[1].to_i
#               product.update_attributes({
#                               description: p[2],
#                               style: p[3],
#                               size_name: p[4],
#                               colour_name: p[5]}, without_protection: true
#                 )
#             else
#               product.create({

#                 }, without_protection: true)
#             end
#           end
#         end
#       end
#     puts "CSV 'Products-Export' Data has been updated"
#     rescue Exception => e
#       puts "Errors were encountered: #{e.class} => #{e.message}"
#     end

#   end
# end
