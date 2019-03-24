# frozen_string_literal: true

require "rails_helper"

RSpec.describe Book do
  context "when create a book without params" do
    it "should have attributes with nil value" do
      expect(subject.title).to be_nil
      expect(subject.author).to be_nil
      expect(subject.publisher).to be_nil
      expect(subject.img_link).to be_nil
      expect(subject.info_link).to be_nil
    end
  end

  context "when create a book with params" do
    let(:book_params) do
      {
        title: "Book's Title",
        author: "Author's Name",
        publisher: "Publisher's Name",
        img_link: "http://example.com/image.png",
        info_link: "http://example.com/moro_info_link"
      }
    end
    subject { Book.new book_params }

    it "should have title, author, publisher, img_link, info_link" do
      expect(subject.title).to eq(book_params[:title])
      expect(subject.author).to eq(book_params[:author])
      expect(subject.publisher).to eq(book_params[:publisher])
      expect(subject.img_link).to eq(book_params[:img_link])
      expect(subject.info_link).to eq(book_params[:info_link])
    end
  end
end
