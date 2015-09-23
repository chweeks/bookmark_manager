require 'sinatra/base'
require_relative 'data_mapper_setup'

class App < Sinatra::Base

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    Link.create(url: params[:url], title: params[:title])
    redirect '/links'
  end

  set :views, proc { File.join(root, '../views') }
  run! if app_file == $0

end
