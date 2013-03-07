require_relative '../../app/models/filler.rb'
require 'test/unit'
require 'mongoid'

class FillerTest < Test::Unit::TestCase
  
  def setup
    Mongoid.load!("mongoid.yml", :test)
    
    Filler.delete_all
    FillerTest.add_samples
  end
  
  def teardown
    Filler.delete_all
  end
  
  def self.add_samples
    Filler.new(
      :type => "radio",
      :filler_name => "Smoking & Pregnancy - Reasons - Partners",
      :coi => "35",
      :client_name => "Department of Health",
      :campaign_name => "Stop Smoking",
      :length => 40
      ).save
    Filler.new(
      :type => "tv",
      :filler_name => " - DRIVING AROUND HORSES",
      :coi => "234",
      :client_name => "Department for Transport",
      :campaign_name => "ROAD SAFETY",
      :length => 60
      ).save
  end
  
  def test_filler
    filler = Filler.where(type: "radio").first
    
    assert !filler.nil?
    assert_equal('radio', filler.type)
    assert_equal('Smoking & Pregnancy - Reasons - Partners', filler.filler_name)
    assert_equal('35', filler.coi)
    assert_equal('Department of Health', filler.client_name)
    assert_equal('Stop Smoking', filler.campaign_name)
    assert_equal(40, filler.length)
  end
  
  def test_find_all_tv
    assert Filler.where(type: "tv").count > 0
  end
  
  def test_find_all_radio
    assert Filler.where(type: "radio").count > 0
  end

end
