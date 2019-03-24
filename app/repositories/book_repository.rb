# frozen_string_literal: true

class BookRepository
  def initialize(book_api)
    @book_api = book_api
  end

  def search(q)
    @book_api.query(convert_query(q))
  end

  private

    def convert_query(q)
      q.gsub(/\s+/, '+')
    end
end
