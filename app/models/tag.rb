require_relative '../data_mapper_setup'

module Bookmark
  module Models
    class Tag

      include DataMapper::Resource

      property :id,  Serial
      property :name, String

      has n, :links, through: Resource

    end
  end
end
