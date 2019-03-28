# frozen_string_literal: true

require "rails_helper"

RSpec.describe BooksController, type: :controller do
  context "GET /books" do
    context "when the search query is empty" do
      before { get :index, params: { search_field: "" } }

      it "returns HTTP status 200" do
        expect(response).to have_http_status :ok
      end

      it "books is assigned to empty list" do
        expect(assigns(:books)).to be_empty
      end

      it "renders the index template" do
        expect(response).to render_template("index")
      end
    end

    context "when the search query is NOT empty" do
      shared_context "successful request" do
        it "returns HTTP status 200" do
          expect(response).to have_http_status :ok
        end

        it "renders the index template" do
          expect(response).to render_template("index")
        end
      end
      let(:params) { { search_field: "sail", currentPage: 1 } }

      context "when currentPage has defualt value" do
        before { get :index, params: params }

        include_context "successful request"

        it "books is assigned to empty list" do
          expect(assigns(:books)).to_not be_empty
        end
      end

      context "when currentPage has defualt value + 1" do
        before { get :index, params: params }

        include_context "successful request"

        it "books is assigned to empty list" do
          expect(assigns(:books)).to_not be_empty
        end
      end

      context "when currentPage has defualt value + 1000" do
        let(:params) { { search_field: "sail", currentPage: 1000 } }
        before { get :index, params: params }

        include_context "successful request"

        it "books is assigned to empty list" do
          expect(assigns(:books)).to be_empty
        end
      end
    end
  end
end
