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
      puts n
    #   pub fn idf(&self, kw: &str) -> f64 {
    #     let n = self.number_of_documents() as f64;
    #     let n_kw = self.get_urls(kw).len() as f64;
    #     ((n - n_kw + 0.5) / (n_kw + 0.5) + 1.0).ln()
    # }
    end
  end
end