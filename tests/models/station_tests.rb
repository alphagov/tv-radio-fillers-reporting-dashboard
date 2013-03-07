require_relative '../../app/models/station.rb'
require 'test/unit'
require 'mongoid'

class StationTest < Test::Unit::TestCase
  
  def setup
    Mongoid.load!("mongoid.yml", :test)
    
    Station.delete_all
    StationTest.add_samples
  end
  
  def teardown
    Station.delete_all
  end
  
  def self.add_samples
    Station.new(
      :type => "tv",
      :station_name => "Channel TV (ITV)",
      :station_type => "Commercial",
      :station_group => "ITV",
      :not_for_profit => false
    ).save
    Station.new(
      :type => "radio",
      :station_name => "Affinity Cambridge",
      :station_type => "Exclusively Online",
      :station_group => "Affinity Cambridge",
      :not_for_profit => true
    ).save
  end
  
  def test_station
    station = Station.where(type: "tv").first

    assert !station.nil?
    assert_equal('tv', station.type)
    assert_equal('Channel TV (ITV)', station.station_name)
    assert_equal('Commercial', station.station_type)
    assert_equal('ITV', station.station_group)
    assert_equal(false, station.not_for_profit)
  end
  
  def test_find_all_tv
    assert Station.where(type: "tv").count > 0
  end
  
  def test_find_all_radio
    assert Station.where(type: "tv").count > 0
  end

end
