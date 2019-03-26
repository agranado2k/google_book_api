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
    let(:base_url) { "https://www.googleapis.com" }
    let(:resource) { "/books/v1/volumes" }
    let(:q_string) { "#{term}&key=#{google_api_key}" }
    let(:request_params) { "#{base_url}#{resource}?q=#{q_string}" }
    subject { GoogleBookApiService.new(google_api_key, http_client) }
    before(:each) do
      allow(http_client).to receive(:get)
        .with(request_params)
        .and_return(api_response)
    end

    it "should receive book list" do
      books = subject.query(term)

      expect(books).to_not be_empty
      expect(books[0]).to be_a Book
    end
  end
end
