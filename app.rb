#!/usr/bin/env ruby

require 'sinatra'
require 'sinatra/activerecord'

configure(:development){ set :database, "sqlite3:project_database.sqlite3"}
set :sessions, true

require './models'

def current_user
	if session[:user_id]
		@current_user = User.find(session[:user_id])
	end
end

helpers { alias_method :current_user, :current_user}

get '/' do
	erb :Welcome
end


get '/user_not_found' do
	erb :user_not_found
end


get '/success' do
	@user = current_user
	helpers { alias_method :current_user, :current_user}

	erb :success
end


get '/login_failed' do
	erb :login_failed
end


post '/sign_in' do 
	@user = User.where(email: params[:email]).first
	if !@user
		redirect "/user_not_found"
	elsif @user.password == params[:password] 
		redirect "/success"   
	else 
		redirect "/login_failed"
	end
end

post '/sign_up' do
	puts params[:user]
	@user = User.create(params[:user])
end



