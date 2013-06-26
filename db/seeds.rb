# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Branch.find_by_name('WAREHOUSE').update_attribute(:the_branch, 1)
Branch.find_by_name('RETURNS').update_attribute(:the_branch, 2)
Branch.find_by_name('ECOMMERCE').update_attribute(:the_branch, 3)
Branch.find_by_name('HEAD OFFICE').update_attribute(:the_branch, 4)
Branch.find_by_name('LINCOLN').update_attribute(:the_branch, 5)
Branch.find_by_name('GRIMSBY').update_attribute(:the_branch, 6)
Branch.find_by_name('GAINSBOROUGH').update_attribute(:the_branch, 7)