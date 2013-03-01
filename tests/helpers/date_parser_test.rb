require_relative '../../app/helpers/date_parser.rb'
require 'test/unit'

class DateParserTest < Test::Unit::TestCase
  
  def setup
    @object = Object.new
    @object.extend(DateParser)
  end

  def test_valid_dates
    assert_equal '08/01/2013', @object.parse_date('08-Jan-2013').strftime('%d/%m/%Y')
    assert_equal '08/01/2013', @object.parse_date('08-Jan-13').strftime('%d/%m/%Y')  
    assert_equal '08/01/2013', @object.parse_date('08/01/2013').strftime('%d/%m/%Y')
    assert_equal '08/01/2013', @object.parse_date('08 Jan 2013').strftime('%d/%m/%Y')
    assert_equal '08/01/2013', @object.parse_date('08 Jan 13').strftime('%d/%m/%Y')
    assert_equal '08/01/2013', @object.parse_date('08-01-2013').strftime('%d/%m/%Y')
    assert_equal '08/01/2013', @object.parse_date('08/01/13').strftime('%d/%m/%Y')
    assert_equal '08/01/2013', @object.parse_date('08-01-13').strftime('%d/%m/%Y')
  end
  
  def test_invalid_dates
    exception = assert_raise(ArgumentError) { @object.parse_date('99-Jan-13') }
    assert_equal("Could not parse date: 99-Jan-13", exception.message)
    
    exception = assert_raise(ArgumentError) { @object.parse_date('01/31/2013') }
    assert_equal("Could not parse date: 01/31/2013", exception.message)
  end
  
end
