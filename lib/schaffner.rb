require_relative "search_engine/search_engine"
require_relative "search_engine/mixins/searchable"

module Schaffner
  def self.new
    SearchEngine.new
  end
end