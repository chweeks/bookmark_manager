require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'
require_relative 'data_mapper_setup'
require_relative 'helpers'
require_relative 'controllers/links'
require_relative 'controllers/users'
require_relative 'controllers/sessions'
require_relative 'models/link'
require_relative 'models/user'
require_relative 'models/tag'

module Bookmark
  class BookmarkManager < Sinatra::Base

    include Helpers

    use Rack::MethodOverride
    register Sinatra::Flash
    register Sinatra::Partial

    use Routes::Link
    use Routes::User
    use Routes::Session
    use Models::Link
    use Models::User
    use Models::Tag

    enable :sessions

    set :session_secret, 'super secret'

    run! if app_file == BookmarkManager

  end
end
