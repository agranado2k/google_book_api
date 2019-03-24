# frozen_string_literal: true

require "rails_helper"

RSpec.feature "QueryBooks", type: :feature do
  context "when visiting query books page" do
    it "should show search page empyt" do
      visit "/books"

      expect(page).to have_content "Book's Search Page"
      expect(page).to have_field(id: "search_field")
      expect(page).to have_button "Search"
    end

    it "should default route to books page" do
      visit "/"

      expect(page).to have_current_path "/books"
    end

    context "when make a search" do
      before(:each) do
        visit "/books"
      end

      context "when query is empty" do
        before(:each) { click_button 'Search' }

        it "should return query books page without any results" do
          expect(page).to have_content('No results')
        end
      end

      context "when query is not empty" do

      end
    end
  end
end
