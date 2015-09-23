require_relative '../data_mapper_setup'

class Link

  include DataMapper::Resource

  property :id,    Serial
  property :title, String
  property :url,   String

  has n,   :tags, through: Resource
  
end

class Tag

  include DataMapper::Resource

  property :id,  Serial
  property :name, String

end
