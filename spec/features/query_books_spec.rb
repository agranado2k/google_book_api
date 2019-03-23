require 'rails_helper'

RSpec.feature "QueryBooks", type: :feature do
  context "when visiting query books page" do
    it "should show search page empyt" do
      visit '/books'

      expect(page).to have_field find_field(id: 'search_field')
      expect(page).to have_button 'Search'
    end
  end
end
