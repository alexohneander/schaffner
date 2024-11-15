module Schaffner
  class Indexer
    @index = []

    def self.index
      @index
    end
    def index
      self.class.index
    end

    # Add Documents to the Index
    def add_to_index(document, model)
      puts "Adding #{document} with the Type #{model.name} to the index."
      
      # Cleaning Sanitize
      document.attributes.each do |attr_name, attr_value|
        if attr_value.is_a?(String) && attr_name != "slug"

          attr_value = ActionView::Base.full_sanitizer.sanitize(attr_value)
          attr_value = attr_value.downcase

          document[attr_name] = attr_value
        end
      end

      self.index << [document, model.name]
    end

    def initialize
      # @index = Index.new(index_dir)
    end

    def create_index
      models = get_all_models
      
      models.each do |model|
        records = model.all
        records.each do |record|
          add_to_index(record, model)
        end
      end
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
  end
end