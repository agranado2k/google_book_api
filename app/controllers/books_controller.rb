# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    @books = []
    return if params[:search_field].blank?

    @current_page = change_page(params[:current_page], params[:page_action])
    @books = book_repository.search(params[:search_field], @current_page)
  end

  private

    def change_page(page, action)
      page ||= 0
      page = page.to_i
      page += 1 if action && action == 'forward'
      page -= 1 if action && action == 'backward' && page.positive?
      page
    end

    def book_repository
      google_api_key = Rails.application.credentials.google_api_key!
      book_api = GoogleBookApiService.new(google_api_key)
      BookRepository.new(book_api)
    end
end
