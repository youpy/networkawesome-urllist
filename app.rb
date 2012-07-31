require 'open-uri'
require 'json'
require 'zlib'

set :root, File.dirname(__FILE__)
set :public_folder, 'public'

helpers do
  def show2img(show)
    '<img width="459" height="344" src="http://i3.ytimg.com/vi/%s/hqdefault.jpg" data-id="%s" />' % [show.id, show.id]
  end
end

get '/' do
  url = params[:url]

  content = Zlib::GzipReader.new(open(url, 'Accept-Encoding' => 'gzip, deflate')).read
  kshows  = JSON.parse(content.match(/var kShows = ([^\n]+);/)[1]);
  @url    = url
  @shows  = kshows['shows'].inject([]) do |result, item|
    result + item['clips'].find_all do |clip|
      clip['type'] == 'Regular'
    end.map do |clip|
      Show.new(clip['name'], clip['id'])
    end
  end
  @ids    = @shows.map {|s| s.id }

  haml :index
end

class Show
  attr_reader :name, :id

  def initialize(name, id)
    @name = name
    @id   = id
  end
end
