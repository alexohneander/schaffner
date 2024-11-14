module Schaffner
  class Indexer
    def initialize
      # @index = Index.new(index_dir)
    end

    def create_index
      models = get_all_models
      
      models.each do |model|
        records = model.all
        puts records
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