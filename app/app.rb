require 'sinatra/base'
require_relative 'data_mapper_setup'

class App < Sinatra::Base

  get '/' do
   redirect '/links'
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    link = Link.new(url: params[:url],
                  title: params[:title])
    tags = params[:tags].split(" ")
    tags.each do |tag|
      new_tag = Tag.create(name: tag)
      link.tags << new_tag
    end
    link.save
    redirect '/links'
  end

  get '/tags/:name' do
    tags = Tag.first(name: params[:name])
    @links = tags ? tags.links : []
    erb :'links/index'
  end

  get '/users/new' do
    erb :'users/new'
  end

  set :views, proc { File.join(root, '../views') }
  run! if app_file == $0

end
