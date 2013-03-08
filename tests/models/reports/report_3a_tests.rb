require_relative '../../../app/models/reports/report_3a.rb'
require_relative '../../../app/models/filler.rb'
require_relative '../../../app/models/station.rb'
require_relative '../../../app/models/transmission.rb'
require 'test/unit'
require 'mongoid'

class Report3aTest < Test::Unit::TestCase

  def setup
    Mongoid.load!("mongoid.yml", :test)
    
    Filler.delete_all
    Station.delete_all
    Transmission.delete_all

    Report3aTest.add_sample_data
  end

  def teardown
    #Filler.delete_all
    #Station.delete_all
    #Transmission.delete_all
  end

  def test_generate
    mode = 'tv'
    from_date = DateTime.new(2012, 1, 1)
    to_date = DateTime.new(2013, 1, 1)
    report = Report3a.new(mode, from_date, to_date)

    data = report.generate

    assert(!data[:station_types].nil?, 'station_types should not be nil')
  end
  
  def self.add_sample_data
    stations = []
    stations << Station.new(
      :type => "radio",
      :station_name => "Affinity Cambridge",
      :station_type => "Exclusively Online",
      :station_group => "Affinity Cambridge",
      :not_for_profit => true
    )
    stations << Station.new(
      :type => "radio",
      :station_name => "Quaywest Online",
      :station_type => "Exclusively Online",
      :station_group => "Quaywest Online",
      :not_for_profit => true
    )
    stations << Station.new(
      :type => "radio",
      :station_name => "Absolute 80s",
      :station_type => "Commercial",
      :station_group => "Absolute",
      :not_for_profit => true
    )
    
    fillers = []
    fillers << Filler.new(
      :type => "radio",
      :filler_name => "Smoking & Pregnancy - Reasons - Partners",
      :coi => "35",
      :client_name => "Department of Health",
      :campaign_name => "Stop Smoking",
      :length => 40
    )
    fillers << Filler.new(
      :type => "radio",
      :filler_name => "Smoking & Pregnancy - Reasons - Post Natal",
      :coi => "36",
      :client_name => "Department of Health",
      :campaign_name => "Stop Smoking",
      :length => 40
    )
    fillers << Filler.new(
      :type => "radio",
      :filler_name => "Driving around horses",
      :coi => "234",
      :client_name => "Department for Transport",
      :campaign_name => "Road Safety",
      :length => 60
    )
    
    dates = [Date.new(2011,1,3), Date.new(2012,1,3), Date.new(2012,1,4), Date.new(2013,1,3)]
    
    stations.each do |station|
      station.save
      fillers.each do |filler|
        filler.save
        dates.each do |date|
          Transmission.new(
            :type => "radio", 
            :date => date,
            :time_of_day => "00:01", 
            :filler_name => filler.filler_name, 
            :station_name => station.station_name
          ).save
        end
      end
    end
    
  end
  
end