require_relative 'base_report_test.rb'
require_relative '../../../app/models/reports/report_3a.rb'

class Report3aTest < BaseReportTest

  def test_generate
    mode = 'radio'
    from_date = DateTime.new(2012, 1, 1)
    to_date = DateTime.new(2013, 1, 1)
    report = Report3a.new(mode, from_date, to_date)

    data = report.generate
    
    assert(!data[:station_types].nil?, 'station_types should not be nil')
    assert_equal(2, data[:station_types].length)
  end
  
  def test_generate_1_previous_period
    mode = 'radio'
    from_date = DateTime.new(2010, 1, 1)
    to_date = DateTime.new(2011, 1, 10)
    report = Report3a.new(mode, from_date, to_date)

    data = report.generate
    
    assert(!data[:station_types].nil?, 'station_types should not be nil')
    assert_equal(2, data[:station_types].length)
  end
  
end