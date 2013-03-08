require_relative '../../../app/models/reports/report.rb'
require 'test/unit'

class ReportTest < Test::Unit::TestCase

  def test_new
    from_date = DateTime.new(2012, 1, 1)
    to_date = DateTime.new(2013, 1, 1)
    report = Report.new(from_date, to_date)
    
    assert_equal(from_date, report.from_date)
    assert_equal(to_date, report.to_date)
  end
  
  def test_generate
    from_date = DateTime.new(2012, 1, 1)
    to_date = DateTime.new(2013, 1, 1)
    report = Report3a.new(from_date, to_date)
    data = report.generate
    
    assert(!data.nil?, 'Data is nil')
    assert(data[:from_date], from_date.strftime('%d %B %Y '))
    assert(data[:to_date], to_date.strftime('%d %B %Y '))
  end
  
end