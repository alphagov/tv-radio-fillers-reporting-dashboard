require_relative '../../../app/models/reports/report_3a.rb'
require_relative '../../../app/models/filler.rb'
require_relative '../../../app/models/station.rb'
require_relative '../../../app/models/transmission.rb'
require_relative 'report_tests.rb'
require 'test/unit'
require 'mongoid'

class Report3aTest < Test::Unit::TestCase

  def setup
    Mongoid.load!("mongoid.yml", :test)
    
    Filler.delete_all
    Station.delete_all
    Transmission.delete_all

    ReportTest.add_sample_data
  end

  def teardown
    Filler.delete_all
    Station.delete_all
    Transmission.delete_all
  end

  def test_generate
    mode = 'radio'
    from_date = DateTime.new(2012, 1, 1)
    to_date = DateTime.new(2013, 1, 1)
    report = Report3a.new(mode, from_date, to_date)

    data = report.generate
    puts "Report3a data: #{data}"
    
    assert(!data[:station_types].nil?, 'station_types should not be nil')
    assert_equal(2, data[:station_types].length)
  end
  
end