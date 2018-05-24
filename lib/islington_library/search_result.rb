module IslingtonLibrary
  class SearchResult
    def initialize(book = nil)
      @book = book
    end

    attr_reader :book

    def book?
      book.present?
    end
  end
end
