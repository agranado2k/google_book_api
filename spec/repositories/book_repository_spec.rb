# frozen_string_literal: true

require "rails_helper"

RSpec.describe BookRepository do
  context "when query simple term" do
    let(:current_page) { 1 }

    context "when find results" do
      let(:query) { "simple" }
      let(:params_1) { { title: "Book1", author: "aut1", publisher: "pub1" } }
      let(:params_2) { { title: "Book2", author: "aut2", publisher: "pub2" } }
      let(:book_1) { Book.new(params_1) }
      let(:book_2) { Book.new(params_2) }
      let(:response) { [book_1, book_2] }
      let(:book_api) { double("BookApi", query: response) }
      subject { BookRepository.new(book_api) }

      it "should call book api and get NOT empty list" do
        expected_q = "simple"

        expect(book_api).to receive(:query)
          .with(expected_q, current_page)
          .and_return(response)
        expect(subject.search(query, current_page)).to eq(response)
      end

      context "when query list search terms separated" do
        let(:query) { "query term with results" }
        it "should call book api and get NOT empty list" do
          expected_q = "query+term+with+results"

          expect(book_api).to receive(:query)
            .with(expected_q, current_page)
            .and_return(response)
          expect(subject.search(query, current_page)).to eq(response)
        end
      end

      context "when enclose the phrase in quotation marks" do
        let(:query) { "query \"term with\" results" }
        it "should call book api and get NOT empty list" do
          expected_q = "query+\"term+with\"+results"

          expect(book_api).to receive(:query)
            .with(expected_q, current_page)
            .and_return(response)
          expect(subject.search(query, current_page)).to eq(response)
        end
      end
    end

    context "when doesn't find result" do
      let(:query) { "simple" }
      let(:book_api) { double("BookApi", query: []) }
      subject { BookRepository.new(book_api) }

      it "should call book api and get empty list" do
        expected_q = "simple"

        expect(book_api).to receive(:query)
          .with(expected_q, current_page)
          .and_return([])
        expect(subject.search(query, current_page)).to eq([])
      end
    end
  end
end
