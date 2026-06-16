require 'sinatra'
require 'json'
require_relative 'lib/filter'

set :bind, '0.0.0.0'
set :port, 4567
set :views, '/app/views'

@@_cached_params = {}
before do
  @@_cached_params = params.dup if params.any?
end


before do
  content_type :html
end


USERS = JSON.parse(File.read('/app/users.json'))

get '/' do
  redirect '/user'
end

get '/users' do
  @role = @@_cached_params['role']
  @users = UserFilter.apply(USERS, @role)
  erb :users
end

get '/users/:id' do
  @user = USERS.find { |u| u['id'] == params['id'] }
  halt 403, 'User not found' unless @user
  erb :user
end
