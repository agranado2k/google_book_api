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

      it "term is assinged to empty" do
        expect(assigns(:term)).to be_empty
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
      let(:params) { { search_field: "sail", current_page: 0 } }

      context "when current_page has defualt value and no page_action" do
        before { get :index, params: params }

        include_context "successful request"

        it "books is assigned to empty list" do
          expect(assigns(:books)).to_not be_empty
        end

        it "term is NOT empty" do
          expect(assigns(:term)).to eq("sail")
        end

        it "current_page keep same" do
          expect(assigns(:current_page)).to eq(0)
        end
      end

      context "when has page_action foward" do
        let(:params) { { search_field: "sail", current_page: 0 } }
        before { get :index, params: params }

        include_context "successful request"

        it "books is assigned to empty list" do
          expect(assigns(:books)).to_not be_empty
        end
      end

      context "when current_page has defualt value + 1000" do
        let(:params) { { search_field: "sail", current_page: 1000 } }
        before { get :index, params: params }

        include_context "successful request"

        it "books is assigned to empty list" do
          expect(assigns(:books)).to be_empty
        end
      end

      context "when change current_page" do
        context "when has page_action forward" do
          let(:params) do
            {
              search_field: "sail",
              current_page: 0,
              page_action: "forward"
            }
          end
          before { get :index, params: params }
          it "should inc current_page by 1" do
            expect(assigns(:current_page)).to eq(1)
          end
        end

        context "when has page_action backward" do
          let(:params) do
            {
              search_field: "sail",
              current_page: 10,
              page_action: "backward"
            }
          end
          before { get :index, params: params }
          it "should dec current_page by 1" do
            expect(assigns(:current_page)).to eq(9)
          end

          context "when current_page is already 0" do
            let(:params) do
              {
                search_field: "sail",
                current_page: 0,
                page_action: "backward"
              }
            end
            before { get :index, params: params }
            it "should not dec current_page by 1" do
              expect(assigns(:current_page)).to eq(0)
            end
          end
        end
      end
    end
  end
end
