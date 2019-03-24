class Book
  attr_reader :title, :author, :publisher, :img_link, :info_link

  def initialize(args = {})
    args.each { |key, value| instance_variable_set("@#{key}", value) }
  end
end
