require_relative '../test_helper.rb'
require_relative '../helpers/csv_parser_radio_test.rb'
require_relative '../helpers/csv_parser_tv_test.rb'

class ReportsTest < Test::Unit::TestCase
  
  def generate_reports_it_ok
    it_ok('/tv/generate-report?report_type=3a_client_reports_transmission_by_filler_and_station&from_date=01%2F01%2F2012&to_date=01%2F01%2F2013')
    it_ok('/radio/generate-report?report_type=3a_client_reports_transmission_by_filler_and_station&from_date=01%2F01%2F2012&to_date=01%2F01%2F2013')
  end

end