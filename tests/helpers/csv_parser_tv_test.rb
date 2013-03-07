require_relative '../../app/helpers/csv_parser_tv.rb'
require_relative '../../app/models/transmission.rb'
require 'test/unit'
require 'csv'

class CsvParserTvTest < Test::Unit::TestCase
  
  DATE_FORMAT = '%d-%b-%y'
  SAMPLE_FILE_FULL_PATH = "tests/helpers/csv_samples/tv_fillers_sample.csv"
  
  def setup
    Mongoid.load!("mongoid.yml", :test)
    Transmission.delete_all
    
    @csv_parser = CsvParserTv.new
  end
  
  def teardown
    Transmission.delete_all
  end

  def test_parse_row
    sample_row = ["06/12/2012", "01:47", "S COI: ROAD SAFETY - DITTIES 0147 0:40 COI/PSFF088/040 Y", "CTV"]
    transmission = @csv_parser.parse_row(sample_row)
    
    assert !transmission.nil?
    assert transmission.type == "tv"
    assert transmission.date.strftime('%d/%m/%Y') == DateTime.new(2012, 12, 6).strftime('%d/%m/%Y')
    assert transmission.time_of_day == sample_row[1]
    assert transmission.station_name == sample_row[3]
    assert transmission.filler_name == sample_row[2]
  end

  def test_parse_row_too_few_rows
    invalid_row = ["06/12/2012", "01:47", "S COI: ROAD SAFETY - DITTIES 0147 0:40 COI/PSFF088/040 Y"]
    
    exception = assert_raise(ArgumentError) { @csv_parser.parse_row(invalid_row) }
    assert_equal("Too few rows", exception.message)
  end
  
  def test_parse_row_invalid_date
    invalid_row = ["12/31/2012", "01:47", "S COI: ROAD SAFETY - DITTIES 0147 0:40 COI/PSFF088/040 Y", "CTV"]
    
    exception = assert_raise(ArgumentError) { @csv_parser.parse_row(invalid_row) }
    assert_equal("Could not parse date: #{invalid_row[0]}", exception.message)
  end
  
  def test_parse_tv_sample_file
    CsvParserTvTest.load_sample_file
    
    transmissions = Transmission.where(type: "tv")
    assert transmissions.count == 10
  end
  
  def self.load_sample_file
    CsvParserTv.new.parse_tv_file(SAMPLE_FILE_FULL_PATH)
  end

end