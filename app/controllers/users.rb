require_relative '../../config/environment'
enable :sessions

get '/users/new' do
	@user = User.new
	erb :main
end


# 1) SIGN UP NEW ACCOUNT
post '/users/create' do
	@user = User.new(params[:user])
	if @user.save # if everything is keyed in perfectly, passed validations of email
		@msg = "Now, You may sign in with your NEW ACCOUNT!"
		erb :main
	else
		@msg = "Invalid Email/ Password!"	
		erb :main
	end	
end


# 2a) LOG IN
post '/users/login' do
	#User key in email, search the @user then check if password is correct
	@user = User.find_by(params[:email])
	@password = params[:user][:password]

	if @user == nil || @user.check_password(@password) == false
		@msg = "User NOT found in system OR Incorrect password."
		erb :main
	elsif @user.check_password(@password) == true
		session[:user_id] = @user.id
		redirect to "/users/login/#{@user.id}"
	end
end

# 2b) SHOW SECRET PAGE AFTER LOGGING IN
get '/users/login/:id' do
	if session[:user_id] != nil #means email IS FOUND, password IS CORRECT
		@user = User.find(params[:id])
		erb :after_logged_in
	else
		erb :main
	end
end


# 3) LINK SHORTENER SECTION (REFER TO Controllers/url.rb)


# 4)LOG OUT
post '/users/logout' do
	session.clear
	redirect to "/users/new"
end