# frozen_string_literal: true

require "rails_helper"

RSpec.describe GoogleBookApiService do
  context "when request with valid key" do
    let(:http_client) { double("Client") }
    let(:api_response) do
      OpenStruct.new(body: file_content(filename: "google_book_api"))
    end
    let(:google_api_key) { "valid_key" }
    let(:term) { "sails" }
    let(:page) { 1 }
    let(:base_url) { "https://www.googleapis.com" }
    let(:resource) { "/books/v1/volumes" }
    let(:q_string) { "#{term}&key=#{google_api_key}" }
    let(:pagination) { "&startIndex=1&maxResults=10" }
    let(:request_params) { "#{base_url}#{resource}?q=#{q_string}#{pagination}" }
    subject { GoogleBookApiService.new(google_api_key, http_client) }
    before(:each) do
      allow(http_client).to receive(:get)
        .with(request_params)
        .and_return(api_response)
    end

    it "should receive book list" do
      books = subject.query(term, page)

      expect(books).to_not be_empty
      expect(books[0]).to be_a Book
    end

    context "when book is populated" do
      let(:book_params) do
        {
          title: "The Secret of Spice",
          author: "Tonia Buxton",
          publisher: "Kings Road Publishing",
          img_link: "http://books.google.com/books/content?id=3Kl0DwAAQBAJ&" \
                    "printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api",
          info_link: "https://play.google.com/store/books/details?id=3Kl0DwAAQBAJ&source=gbs_api"
        }
      end

      it "should book has the attributes" do
        books = subject.query(term, page)
        book = books[0]

        expect(book.title).to eq(book_params[:title])
        expect(book.author).to eq(book_params[:author])
        expect(book.publisher).to eq(book_params[:publisher])
        expect(book.img_link).to eq(book_params[:img_link])
        expect(book.info_link).to eq(book_params[:info_link])
      end

    end
  end
end
