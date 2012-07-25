require File.dirname(__FILE__) + '/spec_helper'

describe 'App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  before do
    @url = 'http://networkawesome.com/2012-7-24/live-music-show-italo-disco'

    stub_request(:get, @url).
      to_return(:body => open(fixture('content.html.gz')).read)
  end

  describe '/' do
    it 'should respond to /' do
      get '/', :url => @url

      puts last_response.body
      last_response.body.should match(/<iframe width="459" height="344"/)
    end
  end
end
