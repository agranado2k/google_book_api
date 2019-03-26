# frozen_string_literal: true

class GoogleBookApiService
  def initialize(api_key, client = RestClient)
    @api_key = api_key
    @client = client
  end

  def query(term)
    base_url = 'https://www.googleapis.com'
    resource = '/books/v1/volumes'
    q_string = "#{term}&key=#{@api_key}"
    params = "#{base_url}#{resource}?q=#{q_string}"
    Rails.logger.debug("params: #{params}")
    response = @client.get params
    create_book_list(response)
  end

  private

    def create_book_list(response)
      json = JSON.parse(response.body, symbolize_names: true)
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
