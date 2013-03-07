require_relative '../../app/helpers/csv_parser_station.rb'
require_relative '../../app/models/transmission.rb'
require 'test/unit'
require 'csv'

class CsvParserStationTest < Test::Unit::TestCase
  
  SAMPLE_FILE_FULL_PATH = "tests/helpers/csv_samples/station_sample.csv"
  
  def setup
    Mongoid.load!("mongoid.yml", :test)
    Station.delete_all
    
    @csv_parser = CsvParserStation.new
  end
  
  def teardown
    Station.delete_all
  end

  def test_parse_row
    sample_row = ['tv','Channel TV (ITV)','Commercial','ITV','false']
    station = @csv_parser.parse_row(sample_row)
    
    assert !station.nil?
    assert_equal(sample_row[0], station.type)
    assert_equal(sample_row[1], station.station_name)
    assert_equal(sample_row[2], station.station_type)
    assert_equal(sample_row[3], station.station_group)
    assert_equal(false, station.not_for_profit)
  end

  def test_parse_row_too_few_rows
    invalid_row = ['tv','Channel TV (ITV)','Commercial','ITV']
    
    exception = assert_raise(ArgumentError) { @csv_parser.parse_row(invalid_row) }
    assert_equal("Too few rows", exception.message)
  end
  
  def test_parse_file
    CsvParserStationTest.load_sample_file
    
    stations = Station.where(type: "tv")
    assert stations.count == 2
  end
  
  def self.load_sample_file
    CsvParserStation.new.parse_file(SAMPLE_FILE_FULL_PATH)
  end

end