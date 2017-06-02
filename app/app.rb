
ENV['RACK_ENV'] ||= "development"

require 'sinatra/base'
require_relative 'data_mapper_setup'


class BookmarkManager < Sinatra::Base

  get '/' do
    redirect '/links'
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/add_links'
  end

  post '/links' do
    link = Link.create(title: params[:title], url: params[:url])
    tags_arr = params[:tags].split(', ')
    tags_arr.each {|tag|
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

end
