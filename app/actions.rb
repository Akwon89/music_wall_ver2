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
  @tracks = Track.where(author: @track.author)
  erb :'tracks/show'
end

post '/tracks' do
  @track = Track.new(
    song_title: params[:song_title],
    author: params[:author],
    url:  params[:url],
    created_at: params[:created_at],
    updated_at: params[:updated_at]
  )
  if @track.save
    redirect '/tracks'
  else
    erb :'tracks/new'
  end
end