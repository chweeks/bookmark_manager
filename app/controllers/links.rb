module Bookmark
  module Routes
    class Link < Sinatra::Base

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

    end
  end
end
