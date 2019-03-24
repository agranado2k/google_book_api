# frozen_string_literal: true

require "rails_helper"

RSpec.describe BookRepository do
  let(:book_api) { nil }
  subject { BookRepository.new(book_api) }

  xcontext "when query simple term" do
    context "when find results" do
      let(:query) { 'query term with results' }
      let(:book_1) { Book.new(title: "Book 1", author: 'someone 1', publisher: 'some publisher 1') }
      let(:book_2) { Book.new(title: "Book 2", author: 'someone 2', publisher: 'some publisher 2') }

      before(:each) do
        book_api = Double('BookApi', query: [book_1, book_2])
        @result = subject.search(query)
      end

      it { expect(@result).to eq([book_1, book_2]) }
    end

    context "when doesn't find result" do
      let(:query) { 'query term without results' }

      before(:each) do
        @result = subject.search(query)
      end

      xit { expect(@result).to be_empty }
    end
  end

  context "when query list search terms separated"

  context "when query search for an exact phrase, enclose the phrase in quotation marks"
end
