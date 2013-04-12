require_relative '../test_helper.rb'

class ReportsTest < Test::Unit::TestCase
  
  def test_generate_reports_report3a_no_data
    it_ok('/tv/generate-report?report_type=3a_client_reports_transmission_by_filler_and_station&from_date=01%2F01%2F2000&to_date=01%2F01%2F2001')
    assert last_response.body.include?('TV Fillers Transmission Report'), "Does not include report header"
    assert last_response.body.include?('No transmissions found'), "Does not include no data found message"
    
    it_ok('/radio/generate-report?report_type=3a_client_reports_transmission_by_filler_and_station&from_date=01%2F01%2F2000&to_date=01%2F01%2F2001')
    assert last_response.body.include?('Radio Fillers Transmission Report'), "Does not include report header"
    assert last_response.body.include?('No transmissions found'), "Does not include no data found message"
  end

end