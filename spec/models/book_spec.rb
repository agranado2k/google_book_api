# frozen_string_literal: true

require "rails_helper"

RSpec.describe Book do
  context "when query simple term" do
    context "when find results" do
      let(:query) { 'query term with results' }

      before(:each) do
        @result = Book.search(query)
      end

      it { expect(@result).to eq([book_1, book_2]) }
    end

    context "when doesn't find result" do
      let(:query) { 'query term without results' }

      before(:each) do
        @result = Book.search(query)
      end

      xit { expect(@result).to be_empty }
    end
  end

  context "when query list search terms separated"

  context "when query search for an exact phrase, enclose the phrase in quotation marks"
end
