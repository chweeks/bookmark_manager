require 'sinatra/base'
require_relative 'data_mapper_setup'
require_relative 'helpers'
require 'sinatra/flash'

class App < Sinatra::Base

  include Helpers

  enable :sessions
  register Sinatra::Flash

  set :session_secret, 'super secret'

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
    @user = User.new
    erb :'users/new'
  end

  post '/users' do
    @user = User.create(email: params[:email],
                       password: params[:password],
                       password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect to('/links')
    else
      flash.now[:notice] = 'Password and confirmation don\'t match'
      erb :'users/new'
    end
  end

  run! if app_file == App

end
