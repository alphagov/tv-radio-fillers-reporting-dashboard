require_relative '../../app/helpers/csv_parser_filler.rb'
require_relative '../../app/models/filler.rb'
require 'test/unit'
require 'csv'

class CsvParserFillerTest < Test::Unit::TestCase
  
  SAMPLE_FILE_FULL_PATH = "tests/helpers/csv_samples/filler_sample.csv"
  
  def setup
    Mongoid.load!("mongoid.yml", :test)
    Filler.delete_all
    
    @csv_parser = CsvParserFiller.new
  end
  
  def teardown
    Filler.delete_all
  end

  def test_parse_row
    sample_row = ['radio','Smoking & Pregnancy - Reasons - Partners','35','Department of Health','Stop Smoking','40']
    filler = @csv_parser.parse_row(sample_row)
    
    assert !filler.nil?
    assert_equal(sample_row[0], filler.type)
    assert_equal(sample_row[1], filler.filler_name)
    assert_equal(sample_row[2], filler.coi)
    assert_equal(sample_row[3], filler.client_name)
    assert_equal(sample_row[4], filler.campaign_name)
    assert_equal(40, filler.length)
  end

  def test_parse_row_too_few_rows
    invalid_row = ['radio','Smoking & Pregnancy - Reasons - Partners','35','Department of Health','Stop Smoking']
    
    exception = assert_raise(ArgumentError) { @csv_parser.parse_row(invalid_row) }
    assert_equal("Too few rows", exception.message)
  end
  
  def test_parse_file
    CsvParserFillerTest.load_sample_file
    
    fillers = Filler.where(type: "radio")
    assert fillers.count == 1
  end
  
  def self.load_sample_file
    CsvParserFiller.new.parse_file(SAMPLE_FILE_FULL_PATH)
  end

end