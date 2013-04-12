require_relative 'base_report_test.rb'
require_relative '../../../app/models/reports/report.rb'

class ReportTest < BaseReportTest

  def test_new
    mode = 'tv'
    from_date = DateTime.new(2012, 1, 1)
    to_date = DateTime.new(2013, 1, 1)
    report = Report.new(mode, from_date, to_date)
    
    assert_equal(from_date, report.from_date)
    assert_equal(to_date, report.to_date)
  end
  
  def test_get_distinct_values_from_hash_array_for_key
    hash_array = [{ :a => "1", :b => "1" }, { :a => "2", :b => "2" }, { :a => "1", :b => "3" } ]
    
    assert_equal(2, Report.get_distinct_values_from_hash_array_for_key(hash_array, Proc.new { |hash| hash[:a] }).length)
  end
  
  def test_get_transmissions_summary_for_period_data
    from_date = DateTime.new(2012, 1, 1)
    to_date = DateTime.new(2013, 1, 1)
    
    transmissions_summary = Report.get_transmissions_summary_for_period_data('radio', from_date, to_date)
    
    count = 0
    transmissions_summary.each do |result|
      assert_equal(2.0, result["value"]["count"])
      assert_equal(3.0, result["value"]["spot_value"])
      count += 1
    end
    
    assert_equal(9, count)
  end
  
  def test_get_station_name_to_station_map_for_transmissions_summary
    transmissions_summary = Report.get_transmissions_summary_for_period_data('radio', DateTime.new(2012, 1, 1), DateTime.new(2013, 1, 1))
    station_name_to_station_map = Report.get_station_name_to_station_map_for_transmissions_summary(transmissions_summary)
    
    assert_equal(3, station_name_to_station_map.keys.length)
    assert_equal("Affinity Cambridge", station_name_to_station_map["Affinity Cambridge"][:station_name])
    assert_equal("Exclusively Online", station_name_to_station_map["Affinity Cambridge"][:station_type])
  end
  
  def test_get_filler_name_to_filler_map_for_transmissions_summary
    transmissions_summary = Report.get_transmissions_summary_for_period_data('radio', DateTime.new(2012, 1, 1), DateTime.new(2013, 1, 1))
    filler_name_to_filler_map = Report.get_filler_name_to_filler_map_for_transmissions_summary(transmissions_summary)
    
    assert_equal(3, filler_name_to_filler_map.keys.length)
    assert_equal("Smoking & Pregnancy - Reasons - Partners", filler_name_to_filler_map["Smoking & Pregnancy - Reasons - Partners"][:filler_name])
    assert_equal("Department of Health", filler_name_to_filler_map["Smoking & Pregnancy - Reasons - Partners"][:client_name])
    assert_equal("Stop Smoking", filler_name_to_filler_map["Smoking & Pregnancy - Reasons - Partners"][:campaign_name])
  end
  
  def test_get_stations_for_transmissions_summary
    transmissions_summary = Report.get_transmissions_summary_for_period_data('radio', DateTime.new(2010, 1, 1), DateTime.new(2011, 1, 1))
    previous_period_transmissions_summary = Report.get_transmissions_summary_for_period_data('radio', DateTime.new(2009, 1, 1), DateTime.new(2010, 1, 1))
    stations = Report.get_stations_for_transmissions_summary(transmissions_summary, previous_period_transmissions_summary)
    
    assert_equal(1, stations.length)
    assert(stations.detect { |s| s[:station_name] == "Affinity Cambridge" }, "could not find station")
  end
  
  def test_get_fillers_for_transmissions_summary
    transmissions_summary = Report.get_transmissions_summary_for_period_data('radio', DateTime.new(2010, 1, 1), DateTime.new(2011, 1, 1))
    fillers = Report.get_fillers_for_transmissions_summary(transmissions_summary)
    
    assert_equal(1, fillers.length)
    assert(fillers.detect { |f| f[:filler_name] == "Smoking & Pregnancy - Reasons - Partners" }, "could not find filler")
  end
  
  def test_get_hash_station_data_for_station_name
    transmissions_summary = Report.get_transmissions_summary_for_period_data('radio', DateTime.new(2012, 1, 1), DateTime.new(2013, 1, 1))
    station_name_to_station_map = Report.get_station_name_to_station_map_for_transmissions_summary(transmissions_summary)
    
    hash_station_data = Report.get_hash_station_data_for_station_name(station_name_to_station_map, "Affinity Cambridge")
    
    assert_equal("Affinity Cambridge", hash_station_data[:station_name])
    assert_equal("Exclusively Online", hash_station_data[:station_type])
  end
  
  def test_get_hash_filler_data_for_filler_name
    transmissions_summary = Report.get_transmissions_summary_for_period_data('radio', DateTime.new(2012, 1, 1), DateTime.new(2013, 1, 1))
    filler_name_to_filler_map = Report.get_filler_name_to_filler_map_for_transmissions_summary(transmissions_summary)
    
    hash_filler_data = Report.get_hash_filler_data_for_filler_name(filler_name_to_filler_map, "Smoking & Pregnancy - Reasons - Partners")

    assert_equal("Department of Health", hash_filler_data[:client_name])
    assert_equal("Stop Smoking", hash_filler_data[:campaign_name])
    assert_equal("Smoking & Pregnancy - Reasons - Partners", hash_filler_data[:filler_name])
    assert_equal("35", hash_filler_data[:coi])
    assert_equal(40, hash_filler_data[:length])
  end
  
  def test_generate
    mode = 'tv'
    date_string_format = '%d %B %Y'
    from_date = DateTime.new(2012, 1, 1)
    to_date = DateTime.new(2013, 1, 1)
    report = Report.new(mode, from_date, to_date)

    data = report.generate

    assert(!data.nil?, 'Data is nil')
    assert_equal(mode, data[:mode])
    assert_equal(from_date.strftime(date_string_format), data[:from_date])
    assert_equal(to_date.strftime(date_string_format), data[:to_date])
  end
  
end