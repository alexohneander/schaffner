module Schaffner
  class Indexer

    @index = { documents: [], entry: [] }

    def self.index
      @index
    end

    def index
      self.class.index
    end

    def initialize
      # @index = Index.new(index_dir)
    end

    def create_index
      # Empty Index, to start fresh
      self.index[:documents] = []
      self.index[:entry] = []

      models = get_all_models
      
      models.each do |model|
        records = model.all
        records.each do |record|
          add_to_index(record, model)
        end
      end
    end

    def self.normalize_string(content)
      content = normalize_string(content)
      return content
    end

    def normalize_string(content)
      content = ActionView::Base.full_sanitizer.sanitize(content)
      content = content.downcase
      content = content.parameterize
      content = content.gsub!('-', ' ')

      return content
    end

    private 

    def get_all_models
      # Load all Active Record classes to loop through and index
      Rails.application.eager_load!

      searchable_models = []
      models = ActiveRecord::Base.descendants

      models.each do |model|
        if model.method_defined?(:is_searchable)
          searchable_models << model
        end
      end

      return searchable_models
    end

    # Add Documents to the Index
    def add_to_index(document, model)
      puts "Adding #{document} with the Type #{model.name} to the index."
      
      self.index[:documents] << [document, model.name]
    
      # Counting words in document
      word_counts = {}
      document.attributes.each do |attr_name, attr_value|
        if attr_value.is_a?(String)
          attr_value = normalize_string(attr_value)
    
          words = attr_value.split(" ")
          words.each do |word|
            word_counts[word] ||= 0
            word_counts[word] += 1
          end
        end
      end
    
      entry = word_counts.map do |word, count|
        { word: word, id: document.id, model_name: model.name, count: count }
      end
    
      self.index[:entry] << entry.flatten
    end
  end
end