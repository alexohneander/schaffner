require_relative "indexer"

module Schaffner
  class SearchEngine
    @indexer = Indexer.new

    def self.indexer
      @indexer
    end

    def indexer
      self.class.indexer
    end


    def initialize
      puts "Initializing search engine..."
    end

    def search_for(query)
      puts "Searching for #{query}"

      indexer = Indexer.new
      query = indexer.normalize_string(query)
      keywords = query.split(" ")

      url_scores = []

      keywords.each do |keyword|
        keyword_score = bm25(keyword)
        url_scores << [id: 11, model_name: "Post", score: 10]
      end

      return url_scores

      # for kw in keywords {
      #     let kw_urls_score = self.bm25(&kw);
      #     update_url_scores(&mut url_scores, &kw_urls_score);
      # }
      # url_scores
    end

    def create_index
      puts "Creating index..."
      self.indexer.create_index

      index = self.indexer.index
      return index
    end

    private

    def bm25(keyword)
      result = []
      idf_score = idf(keyword)
      puts idf_score
      # let mut result = HashMap::new();
      #   let idf_score = self.idf(kw);
      #   let avdl = self.avdl();
      #   for (url, freq) in self.get_urls(kw) {
      #       let numerator = freq as f64 * (self.k1 + 1.0);
      #       let denominator = freq as f64 + self.k1 * (1.0 - self.b + self.b * self.documents.get(&url).unwrap().len() as f64 / avdl);
      #       result.insert(url.to_string(), idf_score * numerator / denominator);
      #   }
      #   result
    end

    def idf(keyword)
      index = self.indexer.index
      n = index[:documents].count
      docs = get_docs(keyword)
      
      n_keyword = docs.count

      idf = ((n - n_keyword + 0.5) / (n_keyword + 0.5) + 1.0) 
      return idf
    end
    
    def get_docs(keyword)
      n_keyword = []
      entrys_docs = self.indexer.index[:entry]

      entrys_docs.each do |entry_doc|
        entry_doc.each do |entry| 
          if entry[:word] == keyword
            n_keyword << entry
          end
        end
      end

      return n_keyword
    end
  end
end