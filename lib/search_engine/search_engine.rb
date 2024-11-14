require_relative "indexer"

module Schaffner
  class SearchEngine
    def initialize
      puts "Initializing search engine..."
      # Check if a Index Exists. If not, create one
    end

    def search_for(query)
      puts "Searching for #{query}"
    end

    def create_index
      puts "Creating index..."
      indexer = Indexer.new
      indexer.create_index
    end
  end
end