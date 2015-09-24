require 'data_mapper'
require './app/models/link'
require './app/models/tag'
require './app/models/user'

env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

DataMapper.finalize

DataMapper.auto_migrate!
