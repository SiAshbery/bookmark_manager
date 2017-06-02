ENV['RACK_ENV'] ||= "development"

require 'sinatra/base'
require_relative 'data_mapper_setup'
require 'bcrypt'


class BookmarkManager < Sinatra::Base

helpers do
  def current_user
   @current_user ||= User.get(session[:user_id])
  end
end

  enable :sessions
  set :session_secret, 'super secret'

  get '/' do
    redirect '/links'
  end

  get '/links' do
   User.count == 0 ? @email = "New User" : @email = User.first.email
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/add_links'
  end

  post '/links' do
    link = Link.create(title: params[:title], url: params[:url])
    tags_arr = params[:tags].split(', ')
    tags_arr.each { |tag|
      link.tags << Tag.create(name: tag)
      }
      link.save
    redirect '/links'
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :"links/index"
  end

  get "/signup" do
    erb :signup
  end

  post "/new_user" do
    # password = BCrypt::Password.create(params[:password])
    user = User.create(email: params[:email], password: params[:password])
    session[:user_id] = user.id
    redirect "/links"
  end

end
