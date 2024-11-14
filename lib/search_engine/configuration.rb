module Schaffner
  class Configuration
    attr_accessor :default_per_page
    
    def initialize
      @default_per_page = 10
    end
  end
end