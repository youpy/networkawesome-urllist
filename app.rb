require 'open-uri'
require 'json'
require 'zlib'

set :root, File.dirname(__FILE__)

helpers do
  def show2iframe(show)
    '<iframe width="459" height="344" src="http://www.youtube.com/embed/%s" frameborder="0" allowfullscreen></iframe>' % show.id
  end
end

get '/' do
  url = params[:url]

  content = Zlib::GzipReader.new(open(url, 'Accept-Encoding' => 'gzip, deflare')).read
  kshows  = JSON.parse(content.match(/var kShows = ([^\n]+);/)[1]);
  @shows  = kshows['shows'].inject([]) do |result, item|
    result + item['clips'].find_all do |clip|
      clip['type'] == 'Regular'
    end.map do |clip|
      p clip
      Show.new(clip['name'], clip['id'])
    end
  end

  haml :index
end

class Show
  attr_reader :name, :id

  def initialize(name, id)
    @name = name
    @id   = id
  end
end
