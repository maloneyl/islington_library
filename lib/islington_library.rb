require "islington_library/version"
require "islington_library/search"

module IslingtonLibrary
  def self.search(title:, author:)
    Search.new(title, author).result
  end
end
