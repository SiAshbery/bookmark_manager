require 'sinatra/base'
require_relative './models/link'

class BookmarkManager < Sinatra::Base

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/add_links'
  end

  post '/links/create_new_link' do
    Link.create(title: params[:title], url: params[:url])
    redirect '/links'
  end

end