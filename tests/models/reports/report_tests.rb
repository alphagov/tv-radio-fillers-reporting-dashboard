require_relative '../../../app/models/reports/report.rb'
require 'test/unit'

class ReportTest < Test::Unit::TestCase

  def test_new
    mode = 'tv'
    from_date = DateTime.new(2012, 1, 1)
    to_date = DateTime.new(2013, 1, 1)
    report = Report.new(mode, from_date, to_date)
    
    assert_equal(from_date, report.from_date)
    assert_equal(to_date, report.to_date)
  end
  
  def test_get_distinct_values_from_hash_array_for_key
    report = Report.new('tv', DateTime.new(2012, 1, 1), DateTime.new(2013, 1, 1))
    hash_array = [{ :a => "1", :b => "1" }, { :a => "2", :b => "2" }, { :a => "1", :b => "3" } ]
    
    assert_equal(2, report.get_distinct_values_from_hash_array_for_key(hash_array, :a).length)
  end
  
  def test_generate
    mode = 'tv'
    from_date = DateTime.new(2012, 1, 1)
    to_date = DateTime.new(2013, 1, 1)
    report = Report.new(mode, from_date, to_date)

    data = report.generate

    assert(!data.nil?, 'Data is nil')
    assert_equal(mode, data[:mode])
    assert_equal(from_date.strftime('%d %B %Y '), data[:from_date])
    assert_equal(to_date.strftime('%d %B %Y '), data[:to_date])
  end
  
end