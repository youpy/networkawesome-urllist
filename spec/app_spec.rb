require File.dirname(__FILE__) + '/spec_helper'

require 'nokogiri'

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

      doc = Nokogiri::HTML(last_response.body)
      doc.xpath('//img').should have(9).items
    end
  end
end
