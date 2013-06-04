require 'spec_helper'

feature "BranchesController" do
    scenario "renders the branches index" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit branches_path
      expect(page.current_path).to eql('/branches')
    end

    scenario "returns creates a branch " do
      visit new_branch_path
      within("form") do
        fill_in "branch[name]", with: "Lincoln High Street"
        click_button "Create Branch"
      end

      expect(page.current_path).to eql('/branches/1')
      expect(page).to have_content('Branch was successfully created.')
      expect(page).to have_content('Lincoln High Street')
    end

    scenario "should show a store branch" do
      br = Branch.create!(name: 'Grimsby store')

      visit branch_path(br)
      expect(page).to have_content('Grimsby store')
    end
end
