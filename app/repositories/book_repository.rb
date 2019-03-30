# frozen_string_literal: true

class BookRepository
  def initialize(book_api)
    @book_api = book_api
  end

  def search(query, page)
    @book_api.query(convert_query(query), page)
  end

  private

    def convert_query(query)
      query.gsub(/\s+/, '+')
    end
end
