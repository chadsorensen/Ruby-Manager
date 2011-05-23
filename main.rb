require 'rubygems'
require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

class Task
  include DataMapper::Resource

  property :id,           Serial
  property :name,         String
  property :completed_at, DateTime
end

# list all tasks
get '/' do
  @tasks = Task.all
  erb :index
end

# create new task   
post '/task/create' do
  task = Task.new(:name => params[:name])
  if task.save
    status 201
    redirect '/'  
  else
    status 412
    redirect '/'   
  end
end

DataMapper.auto_upgrade!
