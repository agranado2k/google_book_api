# frozen_string_literal: true

require "rails_helper"

RSpec.describe BooksController, type: :controller do
  context 'GET /books' do
    context 'when the search query is empty' do
      before { get :index, params: {q: ""} }

      it 'returns HTTP status 200' do
        expect(response).to have_http_status :ok
      end

      it 'books is assigned to empty list' do
        expect(assigns(:books)).to eq([])
      end

      it "renders the index template" do
        expect(response).to render_template("index")
      end
    end
  end
end
