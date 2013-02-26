ENV['RACK_ENV'] = 'test'

require_relative '../main.rb'
require 'test/unit'
require 'rack/test'

class Test::Unit::TestCase
  include Rack::Test::Methods

  def setup

  end

  def app
    Sinatra::Application
  end
end
