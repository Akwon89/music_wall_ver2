
helpers do
  #check database to see if user exists, if exists return user other wise nil.
  def current_user
    @users = User.all
    @users.find { |u| u[:id] == session[:user_id] }
  end

end

# Homepage (Root path)
get '/' do
  erb :index
end

get '/tracks' do
  @tracks = Track.all
  erb :'tracks/index'
end

get '/tracks/new' do
  @track = Track.new
  erb :'tracks/new'
end

get '/tracks/:id' do
  @track = Track.find params[:id]
  @tracks = Track.where(artist: @track.artist)
  erb :'tracks/show'
end

post '/tracks' do
  @track = Track.new(
    title: params[:title],
    artist: params[:artist],
    url:  params[:url]
  )
  @track.user_id = current_user.id
  if @track.save
    redirect '/tracks'
  else
    erb :'tracks/new'
  end
end

#################
get '/users/new' do
  @user = User.new
  erb :'users/new'
end

post '/users' do
  @user = User.new(
    username: params[:username],
    email: params[:email],
    password:  params[:password]
  )
  if @user.save
    redirect '/users/login'
  else
    erb :'users/new'
  end
end

get '/users/login' do
  erb :'users/login'
end

post '/users/login' do
  @users = User.all
  @user = @users.find { |u| u[:username] == params[:username] }
  if @user && @user[:password] == params[:password]
    session[:user_id] = @user[:id]
  end
  redirect '/tracks'
end

get '/users/logout' do
  session[:user_id] = nil
  redirect '/'
end
#########

post '/voted' do
  @vote = Vote.create(
    user_id: session[:user_id],
    track_id: params[:track_id]
    )
  @vote.save
  redirect '/tracks'
end

post '/voted_in_show/:track_id' do
  @vote = Vote.create(
    user_id: session[:user_id],
    track_id: params[:track_id]
    )
  @vote.save
  redirect "/tracks/#{params[:track_id]}"
end


post '/downvoted' do
  @vote = Vote.find_by(
    user_id: session[:user_id],
    track_id: params[:track_id])
  @vote.destroy
  redirect '/tracks'
end

post '/downvoted_in_show/:track_id' do
  @vote = Vote.find_by(
    user_id: session[:user_id],
    track_id: params[:track_id])
  @vote.destroy
  redirect "/tracks/#{params[:track_id]}"
end
