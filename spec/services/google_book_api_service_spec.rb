# frozen_string_literal: true

require "rails_helper"

def json_data(filename:)
  file_content = file_fixture("#{filename}.json").read
  JSON.parse(file_content, symbolize_names: true)
end

RSpec.describe GoogleBookApiService do
  context "when request with valid key" do
    let(:http_client) { double('Client') }
    let(:api_response) { json_data(filename: "google_book_api") }
    let(:google_api_key) { "valid_key" }
    let(:term) { "sails" }
    let(:base_url) { "https://www.googleapis.com" }
    let(:resource) { "/books/v1/volumes" }
    let(:q_string) { "#{term}&key=#{google_api_key}" }
    let(:request_params) { "#{base_url}#{resource}?q=#{q_string}" }
    subject { GoogleBookApiService.new(google_api_key, http_client) }
    before(:each) do
      allow(http_client).to receive(:get)
        .with(request_params )
        .and_return(api_response)
    end

    it "should receive book list" do
      response = subject.query(term)

      expect(response[:kind]).to eq("books#volumes")
      expect(response[:totalItems]).to be > 0
      expect(response[:items]).to_not be_empty
    end
  end
end
