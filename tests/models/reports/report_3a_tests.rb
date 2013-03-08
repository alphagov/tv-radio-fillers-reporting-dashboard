require_relative '../../../app/models/reports/report_3a.rb'
require 'test/unit'

class Report3aTest < Test::Unit::TestCase

  def test_generate
    from_date = DateTime.new(2012, 1, 1)
    to_date = DateTime.new(2013, 1, 1)
    report = Report3a.new(from_date, to_date)

    assert(!data[:station_types].nil?, 'station_types should not be nil')
  end
  
end