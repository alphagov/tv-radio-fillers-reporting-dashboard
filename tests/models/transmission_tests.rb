require_relative '../../app/models/transmission.rb'
require 'test/unit'
require 'mongoid'

class TransmissionTest < Test::Unit::TestCase
  
  def setup
    Mongoid.load!("mongoid.yml", :test)
    
    Transmission.delete_all
    TransmissionTest.add_samples
  end
  
  def teardown
    Transmission.delete_all
  end
  
  def self.add_samples
    Transmission.new(:type => "tv", :date => Date.new, :time_of_day => "00:01", :station_name => "Test1").save
    Transmission.new(:type => "radio",:date => Date.new, :time_of_day => "00:02", :station_name => "Test2").save
  end
  
  def test_find_all_tv
    fillers = Transmission.where(type: "tv")
    assert fillers.count > 0
  end

end
