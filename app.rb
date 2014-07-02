#!/usr/bin/env ruby

require 'sinatra'
require 'sinatra/activerecord'
require 'bundler/setup'
require 'sinatra/base'
require 'rack-flash'

enable :sessions
use Rack::Flash, :sweep => true
set :sessions, true

configure(:development){ set :database, "sqlite3:project_database.sqlite3"}

require './models'


def current_user
	if session[:user_id]
		@current_user = User.find(session[:user_id])
	end
end

helpers { alias_method :current_user, :current_user}


#GET ROUTES


get '/' do
	@posts = Post.all

	erb :Welcome
end


get '/new_user' do
	erb :new_user
end


get '/profile' do
	@user = current_user

	erb :profile
end

get '/user/:id' do
	
	puts params[:id]

	erb :profile_view
end

get '/login_failed' do
	erb :login_failed
end


get '/all_users' do
	@users = User.all

	erb :all_users
end


get '/log_out' do
	session[:user_id] = nil
	flash[:notice] = "You've been logged out."
	redirect "/"
end

get '/profile/edit' do
	@user = current_user

	erb :profile_edit
end	


get '/delete/check' do
	@user = current_user

	erb :delete_check
end


#POST ROUTES


post '/sign_in' do 
	@user = User.where(email: params[:email]).first
	if !@user
		redirect "/new_user"
	elsif @user.password == params[:password]
		session[:user_id] = @user.id
		flash[:notice] = "You've logged in successfully."
		redirect "/profile"
	else 
		flash[:notice] = "That password doesn't match this email.  Try again!"
		redirect "/"
	end
end


post '/sign_up' do
	puts params[:user]
	@user = User.create(params[:user])
	@profile = Profile.create(params[:profile])
	flash[:notice] = "Cool. Let's make sure you can sign in."
	redirect "/"
end


post '/blog_post/new' do
	puts params[:post]
	@post = Post.create(params[:post])
	flash[:notice] = "Boom.  New blog post."
	redirect "/profile"
end


post '/update/profile' do
	@user = current_user.update_attributes(params[:user])
	current_user.profile.update_attributes(params[:profile])
	flash[:notice] = "Updates successfull"
	redirect "/profile"
end


post '/delete/profile' do
	current_user.posts.destroy
	current_user.profile.destroy
	current_user.destroy
	flash[:notice] = "Profile deleted.  Don't ever come back."
	redirect "/"
end


post '/follow' do
	
end





