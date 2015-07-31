require_relative '../../config/environment'
enable :sessions

get '/' do
  redirect to "/users/new"
end

get '/users/new' do
  @urls = Url.all
  # @user = User.new
  erb :main
end

post '/url/create' do
  if session[:user_id].nil?
    @url = Url.new(long_url: params[:url_input])
    @url.save
  else

    @user = User.find(session[:user_id])
    @url = Url.new(long_url: params[:url_input], user: @user)
    @url.save
    # @user.urls.new(long_url: params[:url_input])
    # @url1 = @url.save #will trigger model/url.rb/before save:method to do checking and generating short_url
    # @user.save
  end

  @urls = Url.all
  redirect "/users/new"
end


get '/:mini_url' do

  @short_url = "http://localhost:9393" + "/#{params[:mini_url]}" #http:// is the domain
  @url = Url.find_by(short_url: @short_url) #USE FIND_BY instead of FIND
  @url.click_count += 1
  @url.save
 
  redirect to "#{@url.long_url}" #remember dont put a slash so that it goes straight to the link instead of localhost:9393/long_url
end


post '/url/:url_id/delete' do
   # @user = User.find(session[:user_id]) 
    @url = Url.find(params[:url_id])
  @url.destroy


redirect to "/users/new"
end