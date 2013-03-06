require_relative '../../app/helpers/csv_parser_radio.rb'
require_relative '../../app/models/transmission.rb'
require 'test/unit'
require 'csv'

class CsvParserRadioTest < Test::Unit::TestCase
  
  DATE_FORMAT = '%d-%b-%y'
  SAMPLE_FILE_FULL_PATH = "tests/helpers/csv_samples/radio_fillers_sample.csv"
  
  def setup
    Mongoid.load!("mongoid.yml", :test)
    Transmission.delete_all
    
    @csv_parser = CsvParserRadio.new
  end
  
  def teardown
    Transmission.delete_all
  end
  
  def test_parse_radio_row
    sample_row = ["CB00003030 Dance On 30s", "Absolute 70s", "2767", "17-Jan-13", "21:34"]
    filler = @csv_parser.parse_radio_row(sample_row)
    
    assert !filler.nil?
    assert filler.type == "radio"
    assert filler.date.strftime('%d/%m/%Y') == DateTime.new(2013, 01, 17).strftime('%d/%m/%Y')
    assert filler.time_of_day == sample_row[4]
    assert filler.station_name == sample_row[1]
    assert filler.impact == sample_row[2]
    assert filler.filler_name == sample_row[0]
  end
  
  def test_parse_radio_row_too_few_rows
    invalid_row = ["Absolute 70s", "2767", "17-Jan-13", "21:34"]
    
    exception = assert_raise(ArgumentError) { @csv_parser.parse_radio_row(invalid_row) }
    assert_equal("Too few rows", exception.message)
  end
  
  def test_parse_radio_row_invalid_date
    invalid_row = ["CB00003030 Dance On 30s", "Absolute 70s", "2767", "01/31/2013", "21:34"]
    
    exception = assert_raise(ArgumentError) { @csv_parser.parse_radio_row(invalid_row) }
    assert_equal("Could not parse date: #{invalid_row[3]}", exception.message)
  end
  
  def test_parse_radio_sample_file
    CsvParserRadioTest.load_sample_file
    
    fillers = Transmission.where(type: "radio")
    assert fillers.count == 12
  end
  
  def self.load_sample_file
    CsvParserRadio.new.parse_radio_file(SAMPLE_FILE_FULL_PATH)
  end

end