require_relative '../../app/models/fillerEntry.rb'
require 'test/unit'
require 'mongoid'

class FillerEntryTest < Test::Unit::TestCase
  
  def setup
    Mongoid.load!("mongoid.yml", :test)
    
    FillerEntry.delete_all
    FillerEntryTest.add_samples
  end
  
  def teardown
    FillerEntry.delete_all
  end
  
  def self.add_samples
    FillerEntry.new(:type => "tv", :date => Date.new, :time_of_day => "00:01", :station_name => "Test1").save
    FillerEntry.new(:type => "radio",:date => Date.new, :time_of_day => "00:02", :station_name => "Test2").save
  end
  
  def test_find_all_tv
    fillers = FillerEntry.where(type: "tv")
    assert fillers.count > 0
  end

end
