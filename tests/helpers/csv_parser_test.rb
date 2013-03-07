require_relative '../../app/helpers/csv_parser.rb'
require 'test/unit'
require 'csv'

class CsvParserTest < Test::Unit::TestCase
  
  SAMPLE_FILE_FULL_PATH = "tests/helpers/csv_samples/generic_sample.csv"
  TEST_LOG_PATH = 'logs/CsvParserTest.log'
  
  def setup
    @csv_parser = TestCsvParser.new
  end

  def test_parse_file
    @csv_parser.parse_sample_file(SAMPLE_FILE_FULL_PATH, TEST_LOG_PATH)
    assert(File.exists?(TEST_LOG_PATH), 'should have created log file')
    assert_equal(3, @csv_parser.parsed_rows.length)
    assert_equal(3, @csv_parser.saved_rows.length)
  end
end

class TestCsvParser < CsvParser
  attr_accessor :parsed_rows, :saved_rows
  
  def parse_row(row)
    @parsed_rows ||= [] 
    @parsed_rows << row.to_s
    TestObject.new(self, row)
  end
  
  def parse_sample_file(file_full_path, test_log_path)
    parse_file(file_full_path, test_log_path)
  end

end

class TestObject
  attr_accessor :parser, :row
  
  def initialize(parser, row)
    @parser = parser
    @row = row
  end
  
  def to_s
    @row.to_s
  end
  
  def save
    @parser.saved_rows ||= []
    @parser.saved_rows << self.to_s
  end

end