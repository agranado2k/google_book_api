# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    @books = []
    return if params[:search_field].blank?

    google_api_key = Rails.application.credentials.google_api_key!
    book_api = GoogleBookApiService.new(google_api_key)
    book_repository = BookRepository.new(book_api)
    @books = book_repository.search(params[:search_field])
  end
end
