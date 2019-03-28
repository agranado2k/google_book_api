# frozen_string_literal: true

class GoogleBookApiService
  def initialize(api_key, client = RestClient)
    @api_key = api_key
    @client = client
  end

  def query(term, page)
    url = create_url(term, page)
    Rails.logger.debug("url: #{url}")
    response = @client.get url
    Rails.logger.debug("response: #{response}")
    create_book_list(response)
  end

  private

    def create_url(term, page)
      base_url = 'https://www.googleapis.com'
      resource = '/books/v1/volumes'
      q_string = "#{term}&key=#{@api_key}"
      pagination = "&startIndex=#{page}&maxResults=10"
      "#{base_url}#{resource}?q=#{q_string}#{pagination}"
    end

    def create_book_list(response)
      json = JSON.parse(response.body, symbolize_names: true)
      return [] if json[:totalItems].zero?

      json[:items].map do |item|
        Book.new create_params(item)
      end
    end

    def create_params(item)
      {
        title: item[:volumeInfo][:title],
        author: authors(item),
        publisher: item[:volumeInfo][:publisher],
        img_link: image(item),
        info_link: item[:volumeInfo][:infoLink]
      }
    end

    def authors(item)
      return 'N/A' if item[:volumeInfo][:authors].nil?
      item[:volumeInfo][:authors].join(', ')
    end

    def image(item)
      return nil if item[:volumeInfo][:imageLinks].nil?
      item[:volumeInfo][:imageLinks][:smallThumbnail]
    end
end
