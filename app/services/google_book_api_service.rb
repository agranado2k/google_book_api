# frozen_string_literal: true

class GoogleBookApiService
  def initialize(api_key, client=RestClient)
    @api_key = api_key
    @client = client
  end

  def query(term)
    base_url = "https://www.googleapis.com"
    resource = "/books/v1/volumes"
    q_string = "#{term}&key=#{@api_key}"
    params = "#{base_url}#{resource}?q=#{q_string}"
    @client.get params
  end
end
