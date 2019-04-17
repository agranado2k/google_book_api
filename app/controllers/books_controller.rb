# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    @current_page = param_current_page
    @books = []
    return if params[:search_field].blank?

    google_api_key = Rails.application.credentials.google_api_key!
    book_api = GoogleBookApiService.new(google_api_key)
    book_repository = BookRepository.new(book_api)
    @books = book_repository.search(params[:search_field], @current_page)
  end

  private

    def param_current_page
      page = params[:current_page].nil? ? 0 :  params[:current_page].to_i
      action = params[:page_action]
      if !action.nil? && action == 'forward'
        page += 1
      end

      if !action.nil? && action == 'backward' && page > 0
        page -= 1
      end

      page
    end
end
