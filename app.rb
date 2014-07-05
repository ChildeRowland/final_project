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
	@user = current_user

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


get '/delete/profile' do
	current_user.posts.each{|post| post.destroy}
	current_user.profile.destroy
	current_user.destroy
	flash[:notice] = "Fine! We didn't want to be your friend anyway."
	redirect "/"
end


get '/follow' do
	flash[:notice] = "Feature not yet implemented."
	redirect "/profile"
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
	@profile = Profile.new(params[:profile])
	@profile.user_id = @user.id
	@profile.picture = "http://www.publicdomainpictures.net/pictures/50000/nahled/smiley-silhouette.jpg"
	@profile.save!

	@post = Post.new(params[:profile])
	@post.user_id = @user.id
	@post.blog_post = "First Post, to make sure everything is working properly."
	@post.created = Time.now
	@post.save!
	
	# @profile = @user.profile.create(params[:profile])
	# @post = @user.post.create(params[:post])	
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


