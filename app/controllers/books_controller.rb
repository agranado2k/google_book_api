# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    @books = []
    @term = params.fetch(:search_field, '')
    return if @term.blank?

    @current_page = change_page
    @books = book_repository.search(@term, @current_page)
  end

  private

    def change_page
      page = params.fetch(:current_page, 0).to_i
      action = params.fetch(:page_action, '')
      page += 1 if action == 'forward'
      page -= 1 if action == 'backward' && page.positive?
      page
    end

    def book_repository
      google_api_key = Rails.application.credentials.google_api_key!
      book_api = GoogleBookApiService.new(google_api_key)
      BookRepository.new(book_api)
    end
end
