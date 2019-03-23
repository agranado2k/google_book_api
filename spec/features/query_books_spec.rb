require 'rails_helper'

RSpec.feature "QueryBooks", type: :feature do
  context "when visiting query books page" do
    it "should show search page empyt" do
      visit '/books'

      expect(page).to have_content 'Books page'
      expect(page).to have_field(id: 'search_field')
      expect(page).to have_button 'Search'
    end

    it "should default route to books page" do
      visit '/'

      expect(page).to have_current_path '/books'
    end
  end
end
