# Schaffner

A Ruby on Rails module for integrating a simple Search Engine into your Rails application.

## Overview

The `schaffner.rb` file provides a simple way to create instances of search engines using the `SearchEngine` class from the `search_engine/search_engine.rb` file. The `Schaffner` module also includes a mixin (`searchable`) from the same file.

## Usage

To use this codebase, you must include the `searchable` mixin in your ActiveRecord models using `include Schaffner::Searchable`. This will enable the search engine to automatically index the content of your records. Once included, you can start querying your database for specific terms and phrases.

## Example

```ruby
class MyModel < ApplicationRecord
  include Schaffner::Searchable
end
