require_relative '../test_helper.rb'

class DashboardTest < Test::Unit::TestCase
  def test_it_has_links
    get "/tv"
    assert last_response.ok?
    assert last_response.body.include?('href="/tv/import"')
    assert last_response.body.include?('href="/tv/reports"')
    assert last_response.body.include?('href="/tv/transmissions"')
    
    assert last_response.body.include?('href="/tv/generate-report?report_type=3a_client_reports_transmission_by_filler_and_station'), "has quick report link"

    get "/radio"
    assert last_response.ok?
    assert last_response.body.include?('href="/radio/import"')
    assert last_response.body.include?('href="/radio/reports"')
    assert last_response.body.include?('href="/radio/transmissions"')
    
    assert last_response.body.include?('href="/tv/generate-report?report_type=3a_client_reports_transmission_by_filler_and_station'), "has quick report link"
  end
end