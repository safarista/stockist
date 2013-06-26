class AddTheStoreToBranches < ActiveRecord::Migration
  def change
    add_column :branches, :the_branch, :integer
  end
end
